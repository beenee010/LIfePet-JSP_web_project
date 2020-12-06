package utils;

public class Util {
	public int getPageCount(int numPerPage, int dataCount) {
		
		int pageCount = 0;
		pageCount = dataCount/numPerPage;
		
		if(dataCount % numPerPage != 0)
			pageCount++;
		
		return pageCount;
		
	}
	
	public String pageIndexList(int currentPage, int totalPage, String boardUrl) {
		
		int numPerBlock = 5;
		int currentPageSetup;
		int page;
		
		StringBuffer sb = new StringBuffer();
		if(currentPage==0 || totalPage==0)
			return "";
		
		boardUrl = boardUrl + "?";
		
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
		
		if(currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;
		
		if(totalPage > numPerBlock && currentPageSetup > 0)
			sb.append("<li class=\"page-item\"><a class=\"page-link\" href=\"" + boardUrl + "page=" + currentPageSetup + "\"><span aria-hidden=\"true\">&laquo;</span></a></li>");
		
		page = currentPageSetup + 1;
		
		while(page <= totalPage && page <= (currentPageSetup + numPerBlock)) {
			if(page == currentPage) {
				sb.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"" + boardUrl + "page=" + page + "\">" + page + "</a></li>");
			}
			else {
				sb.append("<li class=\"page-item\"><a class=\"page-link\" href=\"" + boardUrl + "page=" + page + "\">" + page + "</a></li>");
			}
			page++;
		}
		
		if(totalPage - currentPageSetup > numPerBlock) {
			sb.append("<li class=\"page-item\"><a class=\"page-link\" href=\"" + boardUrl + "page=" + page + "\"><span aria-hidden=\"true\">&laquo;</span></a></li>");
		}
		return sb.toString();
	}
}
