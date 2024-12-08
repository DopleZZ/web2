package project.demo;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class FilterURL implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
        if(httpRequest.getRequestURI().equals("/areaCheckServlet")){
            httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
            httpResponse.sendRedirect("https://www.youtube.com/watch?v=f8mL0_4GeV0");
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void destroy() {
    }
}