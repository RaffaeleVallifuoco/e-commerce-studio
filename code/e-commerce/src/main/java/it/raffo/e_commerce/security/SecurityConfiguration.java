package it.raffo.e_commerce.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
                .cors(cors -> cors.disable())
                .authorizeHttpRequests(request -> request
                        .requestMatchers(
                                "/index",
                                "/home/",
                                "/home/**",
                                "/img/**",
                                "/css/**",
                                "/js/**",
                                "/webjars/**",
                                "/uploads/**",
                                "/logout",
                                "/logout-success")
                        .permitAll()
                        .requestMatchers("/dash/**").hasAuthority("ADMIN")
                        .anyRequest().authenticated())
                .formLogin(login -> login
                        .loginPage("/login")
                        .loginProcessingUrl("/authentication")
                        .successHandler((request, response, authentication) -> {
                            request.getSession().removeAttribute("SPRING_SECURITY_SAVED_REQUEST");

                            boolean isAdmin = authentication.getAuthorities().stream()
                                    .anyMatch(auth -> auth.getAuthority().equals("ADMIN"));
                            if (isAdmin) {
                                response.sendRedirect("/dash/home");
                            } else {
                                response.sendRedirect("/home/");
                            }
                        })
                        .permitAll())
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/logout-success")
                        .permitAll())
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .accessDeniedPage("/403")); // Configura la pagina di errore per accesso negato

        return http.build();
    }

    @Bean
    DatabaseUserDetailsService userDetailsService() {
        return new DatabaseUserDetailsService();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Bean
    DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());

        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration)
            throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

}
