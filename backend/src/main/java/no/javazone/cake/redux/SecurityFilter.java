package no.javazone.cake.redux;

import com.auth0.jwt.interfaces.DecodedJWT;
import no.javazone.cake.redux.auth0.Auth0Service;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Optional;

public class SecurityFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        if (Configuration.noAuthMode()) {
            request.getSession().setAttribute("username", "Dummyuser");
            chain.doFilter(req, resp);
            return;
        }
        String authorization = request.getHeader("authorization");
        authorization = authorization != null ? authorization : "";
        authorization = authorization.replace("Bearer ", "");
        Optional<DecodedJWT> jwt = new Auth0Service().verify(authorization);
        if (jwt.isPresent()) {
            String email = jwt.get().getClaim("email").asString();
            request.getSession().setAttribute("username", email);
            chain.doFilter(req, resp);
        } else {
            resp.setContentType("text/html");
            resp.getWriter().append("You are not logged in. Blocked.");
        }
    }


    @Override
    public void destroy() {

    }
}
