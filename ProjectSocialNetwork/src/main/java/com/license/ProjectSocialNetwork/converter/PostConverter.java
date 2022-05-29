package com.license.ProjectSocialNetwork.converter;

import com.license.ProjectSocialNetwork.controller.dto.PostDTO;
import com.license.ProjectSocialNetwork.controller.dto.UserDTO;
import com.license.ProjectSocialNetwork.model.Post;
import com.license.ProjectSocialNetwork.model.User;
import org.springframework.stereotype.Component;

@Component
public class PostConverter extends BaseConverter<Long, Post, PostDTO>{
    @Override
    public Post convertDtoToModel(PostDTO dto) {
        Post post = Post.builder()
                .date(dto.getDate())
                .description(dto.getDescription())
                .title(dto.getTitle())
                .build();
        post.setId(dto.getId());
        return post;
    }

    @Override
    public PostDTO convertModelToDto(Post post) {
        PostDTO postdto = PostDTO.builder()
                .date(post.getDate())
                .description(post.getDescription())
                .title(post.getTitle())
                .build();
        postdto.setId(post.getId());
        return postdto;
    }


}
