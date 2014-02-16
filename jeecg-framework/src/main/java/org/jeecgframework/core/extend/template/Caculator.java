package org.jeecgframework.core.extend.template;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Stack;
import java.util.Vector;


/**
 * @author 
 *
 */
public class Caculator {

	public static java.text.NumberFormat nfd = NumberFormat.getNumberInstance(); 
	public static java.text.NumberFormat nfi = NumberFormat.getNumberInstance();
	public static DecimalFormat dfd = (DecimalFormat) nfd; 
	public static DecimalFormat dfi = (DecimalFormat) nfi;
	static{
	dfd.applyPattern("######.00");
	dfi.applyPattern("######");
	}
	class Item
    {
        boolean ops;
        double value;
        
        Character opVal;
        int opPriority;
    }
    
    Stack<Item> opStack=new Stack<Item>();
    Vector<Item> calcStack=new Vector<Item>();
    /**
     * 
     */
    public Caculator() {
        // TODO Auto-generated constructor stub
    }
    
    
    
    
    public String calc()
    {
    	
		
        Stack<Item> tmp=new Stack<Item>();
        while(!calcStack.isEmpty())
        {
            Item it=calcStack.remove(0);
            
            if(!it.ops)
            {
                tmp.push(it);
            }
            else
            {
            	double op2=tmp.pop().value;
            	double op1=0L;//tmp.pop().value;
            	if(!tmp.isEmpty())
            	{
            		 op1=tmp.pop().value;
            	}
                Item newItem=new Item();
                newItem.ops=true;
                switch(it.opVal)
                {
                case '+':
                    newItem.value=op1+op2;
                    
                    break;
                case '-':
                    newItem.value=op1-op2;
                    break;
                case '*':
                    
                    newItem.value=op1*op2;
                    break;
                case '/':
                    
					newItem.value=op1/op2;
					if(newItem.value==Double.NEGATIVE_INFINITY || newItem.value==Double.POSITIVE_INFINITY || new Double(newItem.value).toString().equals("NaN"))
					{
						newItem.value=0.0;
					}
//					double tt=0.0/0.0;
//					double ff=Double.longBitsToDouble(0x7ff8000000000000L);
//					if(new Double(tt).toString().equals("NaN"))
//					{
//						org.jeecgframework.core.util.LogUtil.info(tt);
//					}
						
                    break;
                }
                tmp.push(newItem);
            }
        }
       
        
        Double result = tmp.pop().value;
        
        return getDtoI(result);
        
       /* double c=0;
        long b = (long)Math.round(result * 100); //小数点后两位前移，并四舍五入 
        if((b % 100)!=0)
        {
        	c = (double)b / 100.00; //还原小数点后两位
        	return dfd.format(c);
        }else
        {
        	c = (double)b / 100.00;
        	return dfi.format(c);
        }
        */
    }
    public static String getDtoI(Double d)
    {
    	   double c=0;
           long b = (long)Math.round(d * 100); //小数点后两位前移，并四舍五入 
           if((b % 100)!=0)
           {
           	c = (double)b / 100.00; //还原小数点后两位
           	return dfd.format(c);
           }else
           {
           	c = (double)b / 100.00;
           	return dfi.format(c);
           }
    }
    /**
     * 1)数字直接输出
     * 2)开括号则压栈
     * 3）闭括号把栈中元素依次输出直到遇到开括号
     * 4）运算符时
     *     a)循环，当栈非空，并且栈顶元素不是开括号，并且栈顶运算符优先级不低于输入的运算符的优先级，反复将其输出
     *     b）把输入运算符压栈
     * 5）输出栈内剩余元素
     * @param in
     * @return
     */
    public String transInfixToPosfix(String in)
    {
    	
        char[] cin=in.toCharArray();
        StringBuffer buffer=new StringBuffer();
       
        for(int i=0;i<cin.length;i++)
        {
            Item newItem=new Item();
            newItem.opPriority=1;
            newItem.ops=false;
            
            switch(cin[i])
            {
            
            case '+':
                newItem.opPriority=1;
                newItem.ops=true;
                newItem.opVal='+';
                doOps(buffer, newItem);
                
                break;
            case '-':
                newItem.opPriority=1;
                newItem.ops=true;
                newItem.opVal='-';
                doOps(buffer, newItem);
                break;
            case '*':
                newItem.opPriority=2;
                newItem.ops=true;
                newItem.opVal='*';
                doOps(buffer, newItem);
                break;
            case '/':
                newItem.opPriority=2;
                newItem.ops=true;
                newItem.opVal='/';
                doOps(buffer, newItem);
                break;
                
            case '(':
                newItem.ops=true;
                newItem.opVal='(';
                opStack.push(newItem);
                
                break;
            case ')':
                boolean meetClose=false;
                while(!opStack.isEmpty())
                {
                    Item item=opStack.peek();
                    if(item.ops&&item.opVal!='(')
                    {
                        calcStack.add(item);
                        opStack.pop();
                        buffer.append(item.opVal);
                    }
                    else if(item.ops)
                    {
                        opStack.pop();
                        meetClose=true;
                        break;
                    }
                }
                if(!meetClose)
                {
                	org.jeecgframework.core.util.LogUtil.info(in);
                    throw new RuntimeException();
                }
                break;
                
            default:
                int j=i;
                for(;j<cin.length && ((cin[j]>='0'&&cin[j]<='9') ||cin[j]=='.' || cin[j]=='E');j++);
                if(j==i)
                {
                    throw new RuntimeException("wrong input.");
                }
                newItem.ops=false;
                try {
						newItem.value=Double.parseDouble(new String(cin,i,j-i));
					} catch (NumberFormatException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						org.jeecgframework.core.util.LogUtil.info("cal数字生成错误！！");
					}
                buffer.append(newItem.value);
                calcStack.add(newItem);
                i=j-1;
                break;
                
                
            }
        }
        while(!opStack.isEmpty())
        {
            Item item=opStack.pop();
            calcStack.add(item);
            buffer.append(item.opVal);
            
        }
        return buffer.toString();
        
    }



    private void doOps(StringBuffer buffer, Item newItem) {
        while(!opStack.isEmpty())
        {
            Item item=opStack.peek();
            if(item.opVal!='('&&item.opPriority>=newItem.opPriority)
            {
                calcStack.add(item);
                opStack.pop();
                buffer.append(item.opVal);
            }
            else
            {
                break;
            }
        }
        opStack.push(newItem);
    }
    

    /**
     * @param args
     */
    public static void main(String[] args) {
        Caculator calc=new Caculator();
        
//        org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("1+2*3+7.5-(4/2+8)/5"));
//        org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
        
//        org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("110815.00047*2"));
//        org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
//        org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("110815.125047*2"));
//        org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
        
//        org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("((110815.0347)*2+10)/0"));
//        org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
        
        
//        org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("0.02"));
//        org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
//        org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("0.0"));
//        org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
       
       org.jeecgframework.core.util.LogUtil.info(calc.transInfixToPosfix("1.3E7+0.5"));   
       org.jeecgframework.core.util.LogUtil.info("value is:"+calc.calc());
        Double dd=Double.parseDouble("1.35378957E7");
        
        org.jeecgframework.core.util.LogUtil.info(Caculator.getDtoI(dd));
        
        org.jeecgframework.core.util.LogUtil.info(dd);
        

    }

}

