package org.jeecgframework.tag.core.util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.zip.GZIPOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GzipUtilities {

	public static boolean isGzipSupported(HttpServletRequest request) {
		String encodings = request.getHeader("Accept-Encoding");
		return ((encodings != null) && (encodings.indexOf("gzip") != -1));
	}

	public static boolean isGzipDisabled(HttpServletRequest request) {
		String flag = request.getParameter("disableGzip");
		return ((flag != null) && (!flag.equalsIgnoreCase("false")));
	}

	public static OutputStream getGzipWriter(HttpServletResponse response) throws IOException {
		return (new GZIPOutputStream(response.getOutputStream()));
	}
}
