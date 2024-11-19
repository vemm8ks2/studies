package org.vemm8ks2.config;

import javax.sql.DataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = {"org.vemm8ks2.sample"})
@MapperScan(basePackages = {"org.vemm8ks2.mapper"})
public class RootConfig {

  @Bean
  public DataSource dataSource() {

    HikariConfig hikariConfig = new HikariConfig();

    hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
    hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:XE");
    hikariConfig.setUsername("web");
    hikariConfig.setPassword("1234");

    HikariDataSource dataSource = new HikariDataSource(hikariConfig);

    return dataSource;
  }

  @Bean
  public SqlSessionFactory sqlSessionFactory() throws Exception {

    SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
    sqlSessionFactory.setDataSource(dataSource());

    return (SqlSessionFactory) sqlSessionFactory.getObject();
  }
}
