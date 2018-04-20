package com.cafe24.hosan.document.controller;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.hateoas.Link;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.cafe24.hosan.document.domain.DocumentVO;
import com.cafe24.hosan.document.service.DocumentService;
import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.util.SearchDocumentCriteria;
/*
 * 계층형 게시판 연습.
 */
@Controller
public class DocumentController {

	@Inject
	private DocumentService documentService;
 
	private static DocumentVO addLinks(Model model,DocumentVO docVO) {
		Link selfLink = linkTo(methodOn(DocumentController.class).viewDocument(model,docVO.getDocument_srl())).withSelfRel();
		Link invoiceLink = linkTo(methodOn(DocumentController.class).viewDocument(model,docVO.getDocument_srl())).withRel("invoice");
		 
		docVO.add(selfLink);
		docVO.add(invoiceLink);
		 
		return docVO;
		 
		}
	
	@ResponseBody
	@RequestMapping(value = "/documents/json/documents_list.json", method = RequestMethod.GET)
	private HttpEntity<HashMap<String, Object>> getJsonList(@ModelAttribute("cri") com.cafe24.hosan.util.common.SearchCriteria cri) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		SearchDocumentCriteria srcri = new SearchDocumentCriteria();
		srcri.setPage(cri.getPage());
		srcri.setPageSize(cri.getPageSize());
		srcri.setBlockPage(cri.getBlockPage());

		List<DocumentVO> lists = documentService.getDocumentListJson(srcri, map);
		
		for(DocumentVO p : lists) {
			
			p.add(linkTo(methodOn(DocumentController.class).getJsonList(cri)).slash(p.getId()).withSelfRel());
			}
		
        if (lists.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(map, HttpStatus.OK);
        }

	}

	// list
	@RequestMapping(value = "/documents", method = RequestMethod.GET)
	private String listDocument(Model model) {

		return "document/documents_list";
	}
	

	// write form
	@RequestMapping(value = "/documents/new", method = RequestMethod.GET)
	private String writeFormDocument(Model model) {
		return "document/documents_write";
	}

	// write
	@ResponseBody
	@RequestMapping(value = "/documents", method = RequestMethod.POST)
	private ResponseEntity<Map<String, Object>> writeDocument(@RequestBody DocumentVO vo, Model model, HttpSession session) {
		ResponseEntity<Map<String, Object>> entity = null;

		Map<String, Object> map = new HashMap<String, Object>();

		DocumentVO postVO = null;
		
		if (session.getAttribute("loginUserInfo") == null) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotLogin");
		} else {

			postVO = documentService.write(vo);

			if (postVO == null) {
				map.put("result", "fail");
				map.put("errorMsg", "sqlError");
			} else {
				map.put("result", "success");
			}

			
		}

		HttpHeaders responseHeaders = new HttpHeaders();
		URI newPollUri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{document_srl}").buildAndExpand(postVO.getDocument_srl()).toUri();
		responseHeaders.setLocation(newPollUri);
		
		if (((String) map.get("result")).equalsIgnoreCase("success"))
		//	entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		entity = new ResponseEntity<Map<String, Object>>(map, responseHeaders, HttpStatus.CREATED);
		else
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		return entity;
	}

	// re Document
	@ResponseBody
	@RequestMapping(value = "/documents/{document_srl}", method = RequestMethod.POST)
	private ResponseEntity<Map<String, Object>> writeReDocument(@PathVariable Integer document_srl, @RequestBody DocumentVO vo,
			HttpSession session, Model model) {

		ResponseEntity<Map<String, Object>> entity = null;

		Map<String, Object> map = new HashMap<String, Object>();
		
		DocumentVO postVO = null;
		
		if (session.getAttribute("loginUserInfo") == null) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotLogin");
		} else {

			vo.setDocument_srl(document_srl);
			postVO = documentService.reply(vo);

			if (postVO == null) {
				map.put("result", "fail");
				map.put("errorMsg", "sqlError");
			} else {
				map.put("result", "success");
			}			
		}
		
		HttpHeaders responseHeaders = new HttpHeaders();
		URI newPollUri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{document_srl}").buildAndExpand(postVO.getDocument_srl()).toUri();
		responseHeaders.setLocation(newPollUri);
		
		if (((String) map.get("result")).equalsIgnoreCase("success"))
			//entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			entity = new ResponseEntity<Map<String, Object>>(map, responseHeaders, HttpStatus.CREATED);
		else
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		
		String location = "http://localhost:8811/hosan/documents/" + postVO.getDocument_srl();
		HttpHeaders headers = new HttpHeaders(); 
		headers.setLocation(URI.create(location)); 
		
		//ResponseEntity<DocumentVO> response = new ResponseEntity<DocumentVO>(resourceAssembler.toResource(postVO), headers, HttpStatus.CREATED); 		 

		
		return entity;
	}
	
	//view
	@RequestMapping(value="document/{document_srl}/",method=RequestMethod.GET)
	private String viewDocument(Model model,@PathVariable Integer document_srl){
		
		//model -> documentVO 
		
		documentService.view(document_srl,model);
		
		/*DocumentVO vo = documentService.findById(document_srl);
		model.addAttribute("documentVO",vo);
		if (vo == null) {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    } else {
	        vo.add(linkTo(methodOn(DocumentController.class).viewDocument(vo.getId())).withSelfRel());
	        return new ResponseEntity<>(vo, HttpStatus.OK);
	    }*/
		
		return "document/documents_view";
	}

	// modifyForm
	@RequestMapping(value = "document/{document_srl}/edit", method = RequestMethod.GET)
	private ResponseEntity<Map<String, Object>> modifyFormDocument(@PathVariable Integer document_srl) {
		
		DocumentVO vo = documentService.findById(document_srl);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("modifyVO", vo);
		if (vo == null) {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    } else {
	        vo.add(linkTo(methodOn(DocumentController.class).modifyFormDocument(vo.getDocument_srl())).withSelfRel());
	        return new ResponseEntity<>(map, HttpStatus.OK);
	    }
		//return "document/documents_modify";
		
	}

	// modify
	@ResponseBody
	@RequestMapping(value = "/documents/{document_srl}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	private ResponseEntity<Map<String, Object>> modifyDocument(@PathVariable Integer document_srl,@RequestBody DocumentVO vo,HttpSession session) {

		ResponseEntity<Map<String, Object>> entity = null;

		Map<String, Object> map = new HashMap<String, Object>();
		
		vo.setDocument_srl(document_srl);
		
		DocumentVO originVO = documentService.findById(document_srl);
		DocumentVO modifyVO = null;	
		String origin_id = originVO.getUser_id();
		String user_id = ((MemberVO) session.getAttribute("loginUserInfo")).getUser_id();
		
		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");

			} else {

				if ((!user_id.equalsIgnoreCase(origin_id))&&!((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("Y")) {
					map.put("result", "fail");
					map.put("errorMsg", "hasNotAuth");

				} else {

					
					
					modifyVO = documentService.modify(vo);

					if (modifyVO == null) {
						map.put("result", "fail");
						map.put("errorMsg", "sqlError");
					} else {
						map.put("result", "success");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
			map.put("layer_msg", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		HttpHeaders responseHeaders = new HttpHeaders();
		URI newPollUri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{document_srl}").buildAndExpand(modifyVO.getDocument_srl()).toUri();
		responseHeaders.setLocation(newPollUri);
		
		if (((String) map.get("result")).equalsIgnoreCase("success"))
			//entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			entity = new ResponseEntity<Map<String, Object>>(map, responseHeaders, HttpStatus.OK);
		else
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		
		return entity;
	}
	
	//delete
	@RequestMapping(value = "/documents/{document_srl}", method = RequestMethod.DELETE)
    public ResponseEntity<DocumentVO> deleteDocument(@PathVariable("document_srl") Integer document_srl) {
        System.out.println("Fetching & Deleting User with id " + document_srl);
        
        DocumentVO user = documentService.findById(document_srl);
        if (user == null) {
            System.out.println("Unable to delete. User with id " + document_srl + " not found");
            return new ResponseEntity<DocumentVO>(HttpStatus.NOT_FOUND);
        }
 
        documentService.delete(document_srl);
        return new ResponseEntity<DocumentVO>(HttpStatus.NO_CONTENT);
    }

	
	//delete all
	@RequestMapping(value = "/documents/", method = RequestMethod.DELETE)
    public ResponseEntity<DocumentVO> deleteAllDocument() {
        System.out.println("Deleting All Document");
 
        documentService.deleteAll();
        return new ResponseEntity<DocumentVO>(HttpStatus.NO_CONTENT);
    }

}
