function ShellController() {
    
    /* make it a Singleton */
    if (ShellController.prototype._singletonInstance) {
        return ShellController.prototype._singletonInstance;
    }
    ShellController.prototype._singletonInstance = this;

    var self = this;

    this.gatheredShellData = new Array();

    this.shellData = {
        gallery:[
            {type:"image", src:"images/masseg/nointernet.jpg" , poster:null},
            {type:"image", src:"images/masseg/iphone_message_image_right_size.jpg" , poster:null},
            {type:"video", src:"mov/promo.mp4" , poster:"http://thenextstarb.mako.co.il/applicationMakoQA/images/masseg/iphone_message_image_right_size.jpg"},
            {type:"image", src:"images/masseg/nointernet.jpg" , poster:null},
            {type:"image", src:"images/masseg/iphone_message_image_right_size.jpg" , poster:null},
            {type:"video", src:"mov/promo.mp4" , poster:"http://thenextstarb.mako.co.il/applicationMakoQA/images/masseg/iphone_message_image_right_size.jpg"},
            {type:"image", src:"images/masseg/nointernet.jpg" , poster:null},
            {type:"image", src:"images/masseg/iphone_message_image_right_size.jpg" , poster:null}
        ],
        text:"יש חיבור לאינטרנט"
    };
    
    this.attachEvent = function () {
        $("#gear-setting").on('click', this, function () {
               $('.settings-popup').fadeToggle();
               $('#container').toggleClass('blur');
           });

           $("body").on('click', ".blur", this, function () {
               $('.settings-popup').fadeToggle();
               $('#container').toggleClass('blur');
           });

           //window.onload = function () {
           //    var mySwiper = new Swiper('.swiper-container', {
           //        //Your options here:
           //        mode: 'horizontal',
           //        loop: true
           //        //etc..
           //    });
           //}
    }

    this.openShellPage = function () {
        //check out if online
        if (self.updateInternetAccess()) {
            //display enter button
            $(".slidein").removeClass("grey");
            $(".online").css({ "display": "inline-block" });
            $(".offline").css({ "display": "none" });
            $(".slide.btn").show();

            self.setEnter(); //enter button - attach drag
            self.getShellData(); // get Json 

        }
        else//if offline
        {
            //undisplay enter button
            $(".online").css({ "display": "none" });
            $(".slidein").addClass("grey");
            $(".offline").css({ "display": "inline-block" });
            $(".slide.btn").hide();

            self.setOldData();   

        }
        self.attachEvent();
    }

    this.setOldData = function(){
        
        //check local storage 

        var shellDataFromLocalstorge = self.getLocalStorage();
        //if there is data in localstorge
        if (shellDataFromLocalstorge != null) {
            //insert data
            self.setShellPage(shellDataFromLocalstorge);
        }
        else {
            //insert data
            self.setShellPage(self.shellData); //default data
        }
    }

    this.getLocalStorage = function () {
        //Storage.prototype.setArray = function (key, obj) {
        //    return this.setItem(key, JSON.stringify(obj))
        //}
        //Storage.prototype.getArray = function (key) {
        //    return JSON.parse(this.getItem(key))
        //}
        if (localStorage) {
            return (JSON.parse(localStorage.getItem("cachedShellData")));
        }
        return null;
    }

    this.setLocalStorage = function (shellData) {
        if (localStorage) {
            window.localStorage.setItem("cachedShellData", JSON.stringify(shellData));
        }
        //self.gatheredShellData = window.localStorage.getArray("cachedShellData");
    }

    this.getShellData = function () {
        $.ajax({
            type: "GET",
            url: "http://risingstar.theboxsite.com/showData/3/shellDataGalleryPIC.json",
            success: function (data) {
               // alert("success");
                console.log(data);
                self.setShellPage(data);  
                self.setLocalStorage(data); // change localStorage according to Json

            },
            error: function () {
                //alert("error");
                self.setOldData();   
            }
        });
    }

    this.setShellPage = function (data) {
        self.setLocalStorage(data);
        var html = '';
        data = JSON.parse(data);
        
        data.gallery.forEach(function (slide) {
            //self.shellData.gallery.forEach(function (slide) {
            html += '<div class="swiper-slide"> ';
            if (slide.type == "image") {
                html += '   <img src="' + slide.src + '" alt="' + slide.src + '">';
            }
            else {
                html += '       <figure class="team" style="display:none">';
                html += '           <video class="gallery-video" controls="controls"  src="' + slide.src + '" type="video/mp4" poster="' + slide.poster + '">';
                html += '               poster="' + slide.poster + '"';
                html += '           </video>';
                html += '       </figure>';
            }
            html += '   </div>';
        });


        $('.swiper-wrapper').empty().append(html);

        $('.message-with-img-text.detail.online').empty().text(data.text);

        var mySwiper = new Swiper('.swiper-container', {
                   //Your options here:
                   mode: 'horizontal',
                   loop: true
                   //etc..
               });

    }

    this.updateInternetAccess = function () {
        return (navigator.onLine);
        //if (navigator.onLine == false) {
        //    //$(".online").css({ "display": "none" });
        //    //$(".slidein").addClass("grey");
        //    //$(".offline").css({ "display": "inline-block" });
        //    //$(".slide.btn").hide();
        //    //self.setDataOffline();
        //}
        //else {
        //    //$(".slidein").removeClass("grey");
        //    //$(".online").css({ "display": "inline-block" });
        //    //$(".offline").css({ "display": "none" });
        //    //$(".slide.btn").show();
        //    //self.setEnter();
        //    //self.setShellPage();
        //    
        //}
    }

    //this.setDataOffline = function () { 
    //    $('.message-with-img-text.detail.offline').empty().append(localStorage.text);
    //}

    this.setEnter = function() {
               $(".slide.btn.drag").draggable({
                   stack: ".drag",
                   axis: "x",
                   containment: ".slidein",
                   stop: function (event, ui) {
                       var lengthNoPx = ui.helper.css("left").length - 2;
                       var widthInPx = $(".slidein").width();
                       if (ui.helper.css("left").substring(0, lengthNoPx) >= (widthInPx * 0.5)) { //btn position goes over 50%         
                           $(".slide").addClass("register-slide-back");
                           //$(ui.helper).css("left", "4px");
                           window.location.href = "http://thenextstarb.mako.co.il/risingStar/index.html";
                       }
                       else {
                           //$(ui.helper).css("left", "0px");
                           if ($(window).width() > 700) {
                               $(ui.helper).css("left", "10px");
                           }
                           else {
                               $(ui.helper).css("left", "4px");
                           }
                       }
                   }
               });
           }

           
          

}