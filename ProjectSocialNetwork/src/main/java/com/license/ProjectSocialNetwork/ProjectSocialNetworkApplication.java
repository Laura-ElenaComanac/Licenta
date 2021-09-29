package com.license.ProjectSocialNetwork;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.XADataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.web.WebApplicationInitializer;

import javax.persistence.EntityManagerFactory;

//@SpringBootApplication(scanBasePackages = "com.license.ProjectSocialNetwork")//, exclude = { XADataSourceAutoConfiguration.class, DataSourceAutoConfiguration.class })
// @EnableJpaRepositories(value = "com.license.ProjectSocialNetwork.repository", basePackages="com.license.ProjectSocialNetwork")
//@ConditionalOnMissingBean({ LocalContainerEntityManagerFactoryBean.class, EntityManagerFactory.class })

@SpringBootApplication
public class ProjectSocialNetworkApplication extends SpringBootServletInitializer{// implements WebApplicationInitializer {

	public static void main(String[] args){

		SpringApplication.run(ProjectSocialNetworkApplication.class, args);
	}

//	@Override
//	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
//		return builder.sources(ProjectSocialNetworkApplication.class);
//	}

	//private static Class<ProjectSocialNetworkApplication> applicationClass = ProjectSocialNetworkApplication.class;
}
