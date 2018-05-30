package project.bean;

import java.util.List;

import lombok.Data;

@Data
public class ContentDto {

	private List<BoardDto> listBoardDto;
	private List<List<PhotoDto>> listPhotoDto;
	private List<List<ReplyDto>> listReplyDto;
	
}
