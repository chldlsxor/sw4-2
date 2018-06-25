<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
    <meta name="viewport" content="width=device-width, init-scale=1.0">
        <title>로그인</title>    
<!--        디자인 코드 작성 공간-->
        <link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            .container{
                width: 768px;
                margin: auto;
/*                display: inline-block;*/
            }
            .swiper-container, .login-container{
                width: 46%;
                height: 550px;
                margin: 10;
                display: inline-block;
                vertical-align: top;
                text-align: center;
            }
            .swiper-slide > img{
                width: 100%;
                height: 100%;
            }
            .login-wrapper, .btn-wrapper{
                margin: 10px;
                border : 1px solid black;
                padding:10px;
            }
            a:visited, a:link {
            	color:#00A2E8;
            }
            .head > a{
            	font-size:30px;
            	color:white;
            }
            
            @media screen and (max-width:768px){
                .swiper-container{
                    display: none;
                }
                .container{
                    width: 320px;
                }
                .login-container{
                    width: 95%;
                }
                .login-container > .empty-row{
                	display: none;
                }
            }
            @media screen and (max-width:320px){
                .container{
                    width: 100%;
                }
                .login-container{
                    width: 95%;
                }
            }
        </style>
<!--        jQuery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
<!--        스크립트 작성 공간-->
        <script src = "${root}/res/js/swiper.min.js"></script>
        <script>
            $(document).ready(function(){
                //Swiper 생성
//                var swiper = new Swiper("영역", {옵션});
                var swiper = new Swiper(".swiper-container",{
                    //끝과 끝을 연결(반복)
                    loop:true,

                    //이미지 전환 효과를 변경
                    effect:"fade",
                    
                    //자동재생
                    autoplay:{
                        delay:1000,//전환 간격(밀리초)
                    },
                });
                
                $("form").on("submit", function(e){
        			e.preventDefault();//기본 전송 중지
        			var pw = $(this).find("input[name=pw]").val();//원래 입력된 비밀번호
        			var encpw= SHA256(pw);//SHA-256 암호화
        			$(this).find("input[name=pw]").val(encpw);
        			this.submit();//폼을 전송
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
    </head>
    <body>
    	<header>
			<div class="row left head">
				<a href="login">InStory</a>
			</div>
		</header>
        <div class="empty-row"></div>
        <div class="empty-row"></div>
        <div class="container">
            <!-- 이미지 슬라이더 전체 공간 -->
            <div class="swiper-container">
                <!-- 이미지 영역 -->
                <div class="swiper-wrapper">
                    <div class="swiper-slide"><img src="${root}/res/img/bg001.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg002.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg003.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg004.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg005.jpg"></div>
                </div>
            </div>
            <div class="login-container">
            	<div class="empty-row"></div>
                <div class="login-wrapper">
                	<div class="row">
                    	<h1>Instory</h1>
                    </div>
                    <form action="login" method="post">
                    	<div class="row">
                        	<input class="form-input" type="text" placeholder="이메일" name="id" required value="${cookie.save.value}">
                        </div>
                        <div class="row">
                        	<input class="form-input" type="password" placeholder="비밀번호" name="pw" required>
                        </div>
                        <div class="row left">
							<input type="checkbox" name="save" value="remember"
							<c:if test="${cookie.save.value != null}"> checked </c:if>>	아이디 저장
						</div> 
                        <div class="row">
                        	<input class="form-btn" type="submit" value="로그인">
                        </div>
                    </form>
                    <hr>
                    <a href="email?type=reset_pw">비밀번호를 잊으셨나요?</a>
                </div>
                <div class="btn-wrapper">
                    계정이 없으신가요? <a href="email?type=register">가입하기</a>
                </div>
            </div>
        </div>
    </body>
</html>