<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
    <meta name="viewport" content="width=device-width, init-scale=1.0">
        <title>비밀번호 변경</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            *{
                box-sizing: border-box;
                font-size: 18px;
            }
            .select-container, .content-container{
                border:1px solid black;
                min-height: 600px;
            }
            .page-container{
                display: flex;
                /*다음 줄로 넘어가는 것을 허용하겠다*/
                flex-wrap: wrap;
                width: 900px;
            }
            .select-container{
                width: 180px;
            }
            .select{
            	display: block;
            }
            .content-container{
            	padding:20px;
                flex-grow: 1;
            }
            
            table{
                width: 100%;
                border-collapse: collapse;
            }
            .th{
                text-align: right;
                padding: 10px;
                width: 160px;
                margin : 10px;
            }
            .td{
                flex-grow: 1;
                margin-left: 10px;
            }
            .form-control{
            	margin : 10px;
            }
            input[type=submit]{
            	margin-top:20px;
            }
            button{
                width: 100%;
                text-align: left;
                padding: 10px;
                background-color: white;
                border: none;
            }
            .now{
            	font-weight: bold;
                border-left: 3px solid black;
            }
            #edit, #exit{
				color:gray;
			}
            .profile{
                height: 100px;
                width:100px;
                display: inline-block;
                padding : 10px;
            }
            .content{
                flex-grow:1;
                display: inline-block;
                vertical-align: top;
                margin-left: 10px;
            }
            .empty{
            	height:30px;
            }
            
            @media screen and (max-width:768px){
            	.select{
            		display: inline-block;
            	}
                .select-container{
                    width:100%;
                    min-height: 30px;
	            }
	            .th, .td{
	            	display: block;
	            }
	            .th{
	            	text-align: left;
	            }
	            .now{
	                border-top: 3px solid black;
	                border-left: none;
	            }
            }

        </style>
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){
                $("#edit").on("click",function(){
                    location.href="edit";
                });
                $("#edit_pw").on("click",function(){
                    location.href="edit_pw";
                });
                $("#exit").on("click",function(){
                    location.href="exit";
                });
                
				$("#member_edit").on("submit",function(event){
                	event.preventDefault();
                	
					var regex = /^[a-zA-Z0-9]{6,15}$/;
                	
                	if(!regex.test($("#new_pw").val())){
                		alert("비밀번호는 영문숫자 6~15자리 입니다.");
                		return;
                	}else if($("#new_pw").val()!=$("#new_pw_check").val()){
                		alert("비밀번호와 비밀번호확인이 다릅니다.");
                		return;
                	}else{
                		var pw = $(this).find("input[name=pw]").val();//원래 입력된 비밀번호
	        			var encpw= SHA256(pw);//SHA-256 암호화
	        			$(this).find("input[name=pw]").val(encpw);
	        			var new_pw = $(this).find("input[name=new_pw]").val();//원래 입력된 비밀번호
	        			var encnew_pw= SHA256(pw);//SHA-256 암호화
	        			$(this).find("input[name=new_pw]").val(encnew_pw);
                		document.querySelector("#member_edit").submit();
                	}
                });
				
				function SHA256(s){
                    
                    var chrsz   = 8;
                    var hexcase = 0;
                  
                    function safe_add (x, y) {
                        var lsw = (x & 0xFFFF) + (y & 0xFFFF);
                        var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
                        return (msw << 16) | (lsw & 0xFFFF);
                    }
                  
                    function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
                    function R (X, n) { return ( X >>> n ); }
                    function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
                    function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
                    function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
                    function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
                    function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
                    function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
                  
                    function core_sha256 (m, l) {
                         
                        var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,
                            0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
                            0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,
                            0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
                            0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,
                            0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
                            0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,
                            0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
                            0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,
                            0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
                            0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);
             
                        var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);
             
                        var W = new Array(64);
                        var a, b, c, d, e, f, g, h, i, j;
                        var T1, T2;
                  
                        m[l >> 5] |= 0x80 << (24 - l % 32);
                        m[((l + 64 >> 9) << 4) + 15] = l;
                  
                        for ( var i = 0; i<m.length; i+=16 ) {
                            a = HASH[0];
                            b = HASH[1];
                            c = HASH[2];
                            d = HASH[3];
                            e = HASH[4];
                            f = HASH[5];
                            g = HASH[6];
                            h = HASH[7];
                  
                            for ( var j = 0; j<64; j++) {
                                if (j < 16) W[j] = m[j + i];
                                else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
                  
                                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                                T2 = safe_add(Sigma0256(a), Maj(a, b, c));
                  
                                h = g;
                                g = f;
                                f = e;
                                e = safe_add(d, T1);
                                d = c;
                                c = b;
                                b = a;
                                a = safe_add(T1, T2);
                            }
                  
                            HASH[0] = safe_add(a, HASH[0]);
                            HASH[1] = safe_add(b, HASH[1]);
                            HASH[2] = safe_add(c, HASH[2]);
                            HASH[3] = safe_add(d, HASH[3]);
                            HASH[4] = safe_add(e, HASH[4]);
                            HASH[5] = safe_add(f, HASH[5]);
                            HASH[6] = safe_add(g, HASH[6]);
                            HASH[7] = safe_add(h, HASH[7]);
                        }
                        return HASH;
                    }
                  
                    function str2binb (str) {
                        var bin = Array();
                        var mask = (1 << chrsz) - 1;
                        for(var i = 0; i < str.length * chrsz; i += chrsz) {
                            bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
                        }
                        return bin;
                    }
                  
                    function Utf8Encode(string) {
                        string = string.replace(/\r\n/g,"\n");
                        var utftext = "";
                  
                        for (var n = 0; n < string.length; n++) {
                  
                            var c = string.charCodeAt(n);
                  
                            if (c < 128) {
                                utftext += String.fromCharCode(c);
                            }
                            else if((c > 127) && (c < 2048)) {
                                utftext += String.fromCharCode((c >> 6) | 192);
                                utftext += String.fromCharCode((c & 63) | 128);
                            }
                            else {
                                utftext += String.fromCharCode((c >> 12) | 224);
                                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                                utftext += String.fromCharCode((c & 63) | 128);
                            }
                  
                        }
                  
                        return utftext;
                    }
                  
                    function binb2hex (binarray) {
                        var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
                        var str = "";
                        for(var i = 0; i < binarray.length * 4; i++) {
                            str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
                            hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
                        }
                        return str;
                    }
                  
                    s = Utf8Encode(s);
                    return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
                  
                }
            });
        </script>
        <jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/view/template/content_view_script.jsp"></jsp:include>
    </head>
    <body>
    	<jsp:include page="/WEB-INF/view/template/header.jsp"></jsp:include>
		<div class="page-container">
            <div class="select-container">
                <table>
                    <tbody>
                        <td class="select"><button id="edit">프로필 편집</button></td>
                        <td class="select"><button id="edit_pw" class="now">비밀번호 변경</button></td>
                        <td class="select"><button id="exit">회원 탈퇴</button></td>
                    </tbody>
                </table>
            </div>
            <div class="content-container">
            	<div class="row">
            		<div class="profile">
	                    <c:if test="${memberDto.profile=='pic.jpg'}">
							<img class="img-circle" src="${root}/res/img/${memberDto.profile}" width="70" height="70" id="profile">
						</c:if>
						<c:if test="${memberDto.profile!='pic.jpg'}">
							<img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="70" height="70" id="profile">
						</c:if>
					</div>
					<div class="content">
						<div class="empty"></div>
                    	${memberDto.nick}
                    </div>
            	</div>
            	<hr>
                <form action="edit_pw" method="post" id="member_edit">
                    <table>
                        <tbody>
                            <tr>
                                <td class="th">이전 비밀번호</td>
                                <td class="td"><input class="form-control" type="password" name="pw" id="pw" required></td>
                            </tr>
                            <tr>
                                <td class="th">새 비밀번호</td>
                                <td class="td"><input class="form-control" type="password" name="new_pw" id="new_pw" required></td>
                            </tr>
                            <tr>
                                <td class="th">새 비밀번호 확인</td>
                                <td class="td"><input class="form-control" type="password" id="new_pw_check"required></td>
                            </tr>
                            <tr>
                            	<td colspan="2" class="center"><input class="form-btn inline" type="submit" value="비밀번호 변경"></td>
                            </tr>
                        </tbody>
                    </table>
                    <input type="hidden" name="id" value="${memberDto.id}">
                </form>
            </div>
        </div>
    </body>
</html>