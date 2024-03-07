package com.postit.controller;

import java.io.File;
import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.postit.domain.Criteria;
import com.postit.domain.PageDTO;
import com.postit.domain.PostDTO;
import com.postit.service.PostService;
import com.postit.service.PostServiceImpl;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board")
@AllArgsConstructor
public class PostController implements ServletContextAware{
	//자동주입
	@Autowired
	private PostService service;
	@Inject
	PostServiceImpl PostServiceImpl;
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;		
	}
	//등록화면
	@GetMapping("/register")
	public String register() {
		return "board/create";
	} //register.jsp로 이동

	//등록처리
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerBoard(@RequestParam("title") String title,
			@RequestParam("name") String name,
			@RequestParam("password") String password,
			@RequestParam("pcontent") String pcontent,
			@RequestParam("img") MultipartFile img,
			Model model) throws IOException {

		// 각 이미지 파일을 저장하고 파일 경로를 가져오는 로직을 구현
		String filePath = saveFile(img);

		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);
		System.out.println("실제경로 : " + filePath);


		// PostDTO에 데이터 설정
		PostDTO PostDTO = new PostDTO();
		PostDTO.setTitle(title);
		PostDTO.setName(name);
		PostDTO.setPassword(password);
		PostDTO.setPcontent(pcontent);
		PostDTO.setImg(filePath); // 저장된 파일 경로를 설정

		// 서비스를 통해 게시글 등록
		service.register(PostDTO);

		// 등록 후 목록 화면으로 리다이렉트
		return "redirect:/board/main";
	}

	private String saveFile(MultipartFile img) {
		// 파일이 null이거나 비어 있으면 처리하지 않고 그대로 반환
		if (img == null || img.isEmpty()) {
			return ""; //널값으로 리턴
		}

		// 파일을 업로드할 경로를 지정해야 합니다. (예: "c:/upload")
		//	          String uploadPath = "upload";
		String uploadPath = servletContext.getRealPath("/resources/upload");
		System.out.println(uploadPath);
		System.out.println(uploadPath);
		System.out.println(uploadPath);


		// 업로드할 디렉토리가 없으면 생성
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		// 업로드된 파일의 원본 파일 이름과 확장자 추출
		String originalFileName = img.getOriginalFilename();
		String baseName = FilenameUtils.getBaseName(originalFileName);
		String extension = FilenameUtils.getExtension(originalFileName);

		// 저장할 파일 객체 생성
		File dest = new File(uploadPath, originalFileName);

		// 중복된 파일 이름 처리
		int count = 1;
		while (dest.exists()) {
			dest = new File(uploadPath, baseName + "_" + count + "." + extension);
			count++;
		}

		try {
			// 파일 저장
			System.out.println("저장 경로: " + dest.getPath());
			System.out.println("저장 경로: " + dest.getPath());
			System.out.println("저장 경로: " + dest.getPath());
			img.transferTo(dest);

			// 상대 경로로 변환하여 리턴
			 return dest.getName();
		} catch (IOException e) {
			e.printStackTrace(); // 파일 저장 중 예외 발생 시 예외 처리
			return null;
		}
	}
	
	
	@GetMapping("/read")
	public void read(Long pno, Model model) {
		model.addAttribute("postit",service.read(pno));
	}

	@PostMapping("/checkPW")
	public ResponseEntity<String> checkPW(@RequestParam Long pno, @RequestParam String password) {
		// 서비스에 있는 비밀번호 확인 호출
		boolean result=service.checkPW(pno, password);
		if(result ==true) {
			String url = "/board/update?pno="+pno;
			return new ResponseEntity<>(url,HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	//	
	//main
	@GetMapping("/main")
	public void main(Criteria cri, Model model) {
		System.out.println("메인페이지 왔습니다."+ service.read(service.latestRead().getPno()).getImg());
		//최신글 하나 불러오기
	
		if(service.latestRead() !=null)
			model.addAttribute("main",service.read(service.latestRead().getPno()));
		else
			model.addAttribute("main",null);
		model.addAttribute("list",service.getList(cri));
		int total=service.getTotal(cri); //전체글수
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}

	//상세보기.수정화면
	@GetMapping({"/get","/update"})
	public void get(Long pno,@ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(pno));
	}

	//수정처리
		@PostMapping("/update")
		public String modify(PostDTO postDTO,@RequestParam("newImg") MultipartFile newImg, RedirectAttributes rttr) throws IOException {
			if (newImg != null && !newImg.isEmpty()) {
		        // 새로운 이미지가 업로드된 경우
		        String filePath = updateFile(newImg);
		        
		        System.out.println(filePath);
		        System.out.println(filePath);
		        System.out.println(filePath);
		        System.out.println(filePath);
		        System.out.println(filePath);
		        
		        
		        postDTO.setImg(filePath);
		    }
			if(service.update(postDTO)) { //수정처리가 되었으면
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/board/main"; //목록으로 이동
		}
		//★★★★★이미지 수정★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
		
		private String updateFile(MultipartFile newImg) {
			// 파일이 null이거나 비어 있으면 처리하지 않고 그대로 반환
			if (newImg == null || newImg.isEmpty()) {
				return ""; //널값으로 리턴
			}

			// 파일을 업로드할 경로를 지정해야 합니다. (예: "c:/upload")
			//	          String uploadPath = "upload";
			String uploadPath = servletContext.getRealPath("/resources/upload");
			System.out.println(uploadPath);
			System.out.println(uploadPath);
			System.out.println(uploadPath);




			// 업로드된 파일의 원본 파일 이름과 확장자 추출
			String originalFileName = newImg.getOriginalFilename();
			String baseName = FilenameUtils.getBaseName(originalFileName);
			String extension = FilenameUtils.getExtension(originalFileName);
			
			// ★수정된 파일 이름 생성
		    String updateFileName = baseName + "_" + System.currentTimeMillis() + "." + extension;

			// 저장할 파일 객체 생성
			File dest = new File(uploadPath, updateFileName);

			// 중복된 파일 이름 처리
			int count = 1;
			while (dest.exists()) {
				dest = new File(baseName + "_" + count + "." + extension);
				count++;
			}

			try {
				// 파일 저장
				System.out.println("저장 경로: " + dest.getPath());
				System.out.println("저장 경로: " + dest.getPath());
				System.out.println("저장 경로: " + dest.getPath());
				newImg.transferTo(dest);

				// 상대 경로로 변환하여 리턴
				return dest.getName();
			} catch (IOException e) {
				e.printStackTrace(); // 파일 저장 중 예외 발생 시 예외 처리
				return null;
			}
		}
		
		//★★★★★이미지 수정.end★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

	//삭제
	@PostMapping("/remove")
	public String remove(Long pno, RedirectAttributes rttr) {
		System.out.println("삭제");
		if(service.remove(pno)) { //삭제처리가 되었으면
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/main"; //목록으로 이동
	}


}
