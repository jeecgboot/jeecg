package org.jeecgframework.core.servlet;

import java.awt.image.BufferedImage;

import java.io.File;

import java.io.IOException;

import java.io.PrintWriter;

import java.util.Date;

import java.util.HashMap;

import java.util.List;

import java.util.Map;

import javax.imageio.ImageIO;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import org.apache.commons.fileupload.FileUploadException;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadTmpPhotoServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)

	throws ServletException, IOException {

	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)

	throws ServletException, IOException {

		DiskFileItemFactory factory = new DiskFileItemFactory();

		// 设置内存缓冲区，超过后写入临时文件

		factory.setSizeThreshold(10240000);

		// 设置临时文件存储位置

		String base = "";// this.getServletContext().getRealPath("/")+"files";

		File file = new File(base);

		if (!file.exists())

			file.mkdirs();

		factory.setRepository(file);

		ServletFileUpload upload = new ServletFileUpload(factory);

		// 设置单个文件的最大上传值

		upload.setFileSizeMax(10002400000l);

		// 设置整个request的最大值

		upload.setSizeMax(10002400000l);

		upload.setHeaderEncoding("UTF-8");

		request.setCharacterEncoding("utf-8");

		response.setCharacterEncoding("utf-8");

		PrintWriter out = response.getWriter();

		try {

			List<?> items = upload.parseRequest(request);

			FileItem item = null;

			String tpmFilePathName = null;

			String savePath = "";

			Map<String, String> fileNames = new HashMap<String, String>();

			for (int i = 0; i < items.size(); i++) {

				item = (FileItem) items.get(i);

				// 保存文件

				if (!item.isFormField() && item.getName().length() > 0) {

					fileNames.put("oldName", item.getName());

					String suffixName = item.getName().substring(item.getName().lastIndexOf("."));

					String newName = "";

					fileNames.put("newName", newName);

					fileNames.put("fileSize", "");

					// org.jeecgframework.core.util.LogUtil.info(item.getName()+"=="+UploadTool.createPhotoID()+suffixName+"=="+UploadTool.FormetFileSize(item.getSize())+"savePath"+savePath);

					tpmFilePathName = base + newName;// File.separator

					item.write(new File(tpmFilePathName));

					// UploadTool.removeFile(tpmFilePathName);

					BufferedImage bufImg = ImageIO.read(new File(tpmFilePathName));

					// System.out.print("======"+bufImg.getHeight()+"====="+bufImg.getWidth());

					// 数据库操作，包图片的路径及其相应的信息保存到数据库，

					out.print(newName + "^" + bufImg.getHeight() + "^" + bufImg.getWidth());

				}

			}

			// Map<String,String> fileNames =
			// UploadTool.WorkGroupFileUpload(request,
			// Config.getInstance().getLinkfiletmpPath(),
			// Config.getInstance().getLinkfilesavePath());

		} catch (FileUploadException e) {

			out.print(-1);

			e.printStackTrace();

		} catch (Exception e) {

			out.print(-1);

			e.printStackTrace();

		} finally {

			out.flush();

			out.close();

		}

	}

}
