//package com.license.ProjectSocialNetwork;
//
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Map;
//import java.util.Properties;
//import java.util.stream.Collectors;
//
//import javax.persistence.EntityManagerFactory;
//import javax.sql.DataSource;
//
//import org.springframework.beans.factory.annotation.Qualifier;
//import org.springframework.boot.jdbc.DataSourceBuilder;
//import org.springframework.boot.context.properties.ConfigurationProperties;
//import org.springframework.boot.jdbc.DataSourceBuilder;
//import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
//import org.springframework.boot.web.servlet.FilterRegistrationBean;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.Primary;
//import org.springframework.core.io.ClassPathResource;
//import org.springframework.core.io.Resource;
//import org.springframework.core.io.support.PropertiesLoaderUtils;
//import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
//import org.springframework.orm.jpa.JpaTransactionManager;
//import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
//import org.springframework.transaction.PlatformTransactionManager;
//import org.springframework.transaction.annotation.EnableTransactionManagement;
//import org.springframework.web.cors.CorsConfiguration;
//import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
//import org.springframework.web.filter.CorsFilter;
//import org.springframework.web.servlet.config.annotation.CorsRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
//
//@Configuration
//@EnableTransactionManagement
//// @EnableJpaRepositories(
//// entityManagerFactoryRef = "mysqlEntityManager",
//// transactionManagerRef = "mysqlTransactionManager",
//// basePackages = "com.example.demo.dao"
//// )
//@EnableJpaRepositories(
//        entityManagerFactoryRef = "entityManagerFactory",
//        transactionManagerRef = "transactionManager",
//        basePackages = {
//                "com.license.ProjectSocialNetwork.repository" })
//public class MySQLConfiguration {
//
//    /**
//     * MySQL datasource definition.
//     *
//     * @return datasource.
//     */
//    @Primary
//    @Bean
//    @ConfigurationProperties(prefix = "spring.mysql.datasource")
//    public DataSource mysqlDataSource() {
//        return DataSourceBuilder.create().build();
//    }
//
//    /**
//     * Entity manager definition.
//     *
//     * @param builder
//     *            an EntityManagerFactoryBuilder.
//     * @return LocalContainerEntityManagerFactoryBean.
//     */
//    @Primary
//    @Bean(name = "entityManagerFactory")
//    public LocalContainerEntityManagerFactoryBean mysqlEntityManagerFactory(EntityManagerFactoryBuilder builder) {
//        return builder.dataSource(mysqlDataSource()).properties(hibernateProperties())
//                .packages("com.example.demo.entity").persistenceUnit("mysqlPU").build();
//    }
//
//    /**
//     * @param entityManagerFactory
//     * @return
//     */
//    @Primary
//    @Bean(name = "transactionManager")
//    public PlatformTransactionManager transactionManager(
//            @Qualifier("entityManagerFactory") EntityManagerFactory entityManagerFactory) {
//        return new JpaTransactionManager(entityManagerFactory);
//    }
//
//    private Map<String, Object> hibernateProperties() {
//
//        Resource resource = new ClassPathResource("hibernate.properties");
//        try {
//            Properties properties = PropertiesLoaderUtils.loadProperties(resource);
//            properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
//            return properties.entrySet().stream()
//                    .collect(Collectors.toMap(e -> e.getKey().toString(), e -> e.getValue()));
//        } catch (IOException e) {
//            return new HashMap<String, Object>();
//        }
//    }
//
//    @Primary
//    @Bean
//    public WebMvcConfigurer corsConfigurer() {
//        return new WebMvcConfigurerAdapter() {
//            @Override
//            public void addCorsMappings(CorsRegistry registry) {
//                registry.addMapping("/**");
//            }
//        };
//    }
//
//    @Bean
//    public FilterRegistrationBean corsFilter() {
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        CorsConfiguration config = new CorsConfiguration();
//        config.setAllowCredentials(true);
//        config.addAllowedOrigin("http://localhost:4500");
//        config.addAllowedHeader("*");
//        config.addAllowedMethod("*");
//        source.registerCorsConfiguration("/**", config);
//        FilterRegistrationBean bean = new FilterRegistrationBean(new CorsFilter(source));
//        bean.setOrder(0);
//        return bean;
//    }
//
////	@Bean
////	JpaTransactionManager transactionManager(EntityManagerFactory entityManagerFactory) {
////		JpaTransactionManager transactionManager = new JpaTransactionManager();
////		transactionManager.setEntityManagerFactory(entityManagerFactory);
////		return transactionManager;
////	}
//}