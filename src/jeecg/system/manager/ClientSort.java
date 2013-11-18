package jeecg.system.manager;

import java.util.Comparator;

import jeecg.system.pojo.base.Client;

public class ClientSort implements Comparator<Client> {

	@Override
	public int compare(Client prev, Client now) {
		return (int) (now.getLogindatetime().getTime()-prev.getLogindatetime().getTime());
	}

}
