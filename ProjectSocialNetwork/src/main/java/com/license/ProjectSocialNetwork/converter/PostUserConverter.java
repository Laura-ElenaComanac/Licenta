package com.license.ProjectSocialNetwork.converter;

import com.license.ProjectSocialNetwork.controller.dto.PostDTO;
import com.license.ProjectSocialNetwork.controller.dto.PostUserDTO;
import com.license.ProjectSocialNetwork.controller.dto.UserDTO;
import com.license.ProjectSocialNetwork.model.Post;
import com.license.ProjectSocialNetwork.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PostUserConverter extends BaseConverter<Long, Post, PostUserDTO>{
    @Override
    public Post convertDtoToModel(PostUserDTO dto) {
        Post post = Post.builder()
                .date(dto.getDate())
                .description(dto.getDescription())
                .title(dto.getTitle())
                .build();
        post.setId(dto.getId());
        return post;
    }

    @Override
    public PostUserDTO convertModelToDto(Post post) {
        PostUserDTO postdto = PostUserDTO.builder()
                .date(post.getDate())
                .description(post.getDescription())
                .title(post.getTitle())
                .build();
        postdto.setId(post.getId());
        postdto.setUserid(String.valueOf(post.getUser().getId()));
        return postdto;
    }


}
