package com.license.ProjectSocialNetwork.controller.dto;

import lombok.*;

import java.time.LocalDate;

@Getter @Setter
@EqualsAndHashCode
@NoArgsConstructor @AllArgsConstructor
@Data @Builder
public class UserDTO extends BaseDTO<Long>{
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    //    @Enumerated(EnumType.STRING)
//    private Type type;
    private String email;
    private String location;
    private String gender;
    private String birthday;


}
