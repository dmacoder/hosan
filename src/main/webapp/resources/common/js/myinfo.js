
					  					  	
$(document).ready(function(){
	
	 //$("#changeMemberPicture").click(function(){
	//	$("#thumbnail_upload").click();
	//});
	
});
					  	

var sel_file;
$(document).ready(function() {
    $("#thumbnail_upload").on("change", fileChange);
});


function fileChange(e) {
	//alert("onchange");
	e.preventDefault();
	var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
    filesArr.forEach(function(f) {
        if(!f.type.match("image.*")) {
        	popLayerMsg("확장자는 이미지 확장자만 가능합니다.");
            return;
        }
        sel_file = f;
        var reader = new FileReader();
        reader.onload = function(e) {
        	//alert("온로드");
            $("#profile_Img").attr("src", e.target.result);
            $("#top_profile_Img").attr("src", e.target.result);
            //$("#profileImg").css("height", "53px")
        	//$("#profileImg").css("width", "53px")
        }
        reader.readAsDataURL(f);
    });
    var file = files[0]
    console.log(file)
    var formData = new FormData();
    var url = "./uploadProfile";
    formData.append("file", file);
		$.ajax({
    	url: url,
		  data: formData,
		  dataType:'text',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  success: function(data){
			  popLayerMsg("프로필 이미지가 변경 되었습니다.")
		  },
	      error: function (e) {
	    	  popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);

	      }
		})
 		function checkImageType(fileName){
 			var pattern = /jpg$|gif$|png$|jpeg$/i;
 			return fileName.match(pattern);
 		}
 		function getOriginalName(fileName){
 			if(checkImageType(fileName)){
 				return;
 			}
 			var idx = fileName.indexOf("_") + 1 ;
 			return fileName.substr(idx);
 		}
 		function getImageLink(fileName){
 			if(!checkImageType(fileName)){
 				return;
 			}
 			var front = fileName.substr(0,12);
 			var end = fileName.substr(14);
 			return front + end;
 		}
}


