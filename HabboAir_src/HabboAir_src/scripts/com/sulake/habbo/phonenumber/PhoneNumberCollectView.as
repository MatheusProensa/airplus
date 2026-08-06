package com.sulake.habbo.phonenumber
{
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_2;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.utils.TextWindowUtils;
   
   public class PhoneNumberCollectView
   {
      private static const INPUT_MAX_CHARS:int = 30;
      
      private static const ALL_COUNTRY_CODES:Array = ["VU","EC","VN","VI","DZ","VG","VE","DM","VC","DO","VA","DE","UZ","UY","DK","DJ","US","UG","UA","ET","ES","ER","EH","EG","EE","TZ","TT","TW","TV","GD","GE","GF","GA","GB","FR","FO","FK","FJ","FM","FI","WS","GY","GW","GU","GT","GR","GQ","WF","GP","GN","GM","GL","GI","GH","GG","RE","RO","AT","AS","AR","QA","AW","AU","AZ","BA","PT","AC","AD","PW","AG","AE","PR","PS","AF","AL","AI","AO","PY","AM","BW","TG","BY","TD","TK","BS","TJ","BR","BT","TH","TO","TN","TM","TL","CA","BZ","TR","BF","SV","BG","BH","SS","BI","ST","SY","BB","SZ","BD","BE","SX","BN","BO","BQ","BJ","TC","BL","TA","BM","CZ","SD","CY","SC","CX","CW","SE","SH","CV","SG","CU","SJ","SI","SL","SK","SN","SM","SO","SR","CI","RS","CG","CH","RU","RW","CF","CC","CD","CR","CO","CM","CN","SA","CK","SB","CL","LV","LU","LT","LY","LS","LR","MG","MH","ME","MF","MK","ML","MC","MD","MA","MV","MU","MX","MW","MZ","MY","MN","MM","MP","MO","MR","MQ","MT","MS","NF","NG","NI","NL","NA","NC","NE","NZ","NU"
      ,"NR","NP","NO","OM","PL","PM","PH","PK","PE","PF","PG","PA","HK","ZA","HN","HR","HT","HU","ZM","ZW","ID","IE","IL","IM","IN","IO","IQ","IR","YE","IS","IT","JE","YT","JP","JO","JM","KI","KH","KG","KE","KP","KR","KM","KN","KW","KY","KZ","LA","LC","LB","LI","LK"];
      
      private var UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1:HabboPhoneNumber;
      
      private var _window:IFrameController;
      
      private var _inputTextNeedsClearing:Boolean = true;
      
      private var _locales:Array;
      
      public function PhoneNumberCollectView(param1:HabboPhoneNumber, param2:Array)
      {
         super();
         UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1 = null;
      }
      
      public function handleSubmitFailure(param1:int) : void
      {
         _window.findChildByName("phone_number_input").caption = "";
         _inputTextNeedsClearing = true;
         setInputStates(true);
      }
      
      private function createWindow(param1:Array) : void
      {
         var _loc5_:String = null;
         var _loc9_:String = null;
         var _loc7_:int = 0;
         var _loc4_:String = null;
         if(_window)
         {
            return;
         }
         _window = IFrameController(UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.windowManager.buildFromXML(XML(UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.assets.getAssetByName("phonenumber_collect_xml").content)));
         _window.center();
         _window.findChildByName("never_link").procedure = onInput;
         _window.findChildByName("skip_link").procedure = onInput;
         _window.findChildByName("ok_button").procedure = onInput;
         _window.findChildByName("header_button_close").procedure = onInput;
         _window.findChildByName("phone_number_input").procedure = onInput;
         ITextFieldWindow(_window.findChildByName("phone_number_input")).maxChars = 30;
         var _loc6_:String = UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.localizationManager.getLocalization("phone.number.collect.countries") || "{}";
         var _loc3_:Object = new JSONDecoder(_loc6_,false).getValue();
         var _loc8_:Array = ALL_COUNTRY_CODES.concat();
         _locales = [];
         for each(_loc5_ in _loc8_)
         {
            _loc9_ = _loc3_[_loc5_];
            if(_loc9_ != null && _loc9_.length > 0)
            {
               _locales.push({
                  "code":_loc5_,
                  "name":_loc9_
               });
            }
         }
         _locales.sortOn("name");
         _loc7_ = param1.length - 1;
         while(_loc7_ >= 0)
         {
            _loc5_ = param1[_loc7_];
            if(ALL_COUNTRY_CODES.indexOf(_loc5_) != -1)
            {
               _loc4_ = _loc3_[_loc5_];
               _locales.unshift({
                  "code":_loc5_,
                  "name":_loc4_
               });
            }
            _loc7_--;
         }
         var _loc10_:IDropBaseController_2 = IDropBaseController_2(_window.findChildByName("country_list"));
         for each(var _loc2_ in _locales)
         {
            _loc10_.addMenuItem(createCountrySelectorMenuItem(_loc2_.code,_loc2_.name));
         }
         if(_loc10_.numMenuItems > 0)
         {
            _loc10_.selection = 0;
         }
         TextWindowUtils.setHTMLLinkStyle(_window.findChildByName("collect_summary") as ITextWindow,3369621,16777215,4306905);
         _window.findChildByName("ok_button").disable();
         setInputStates(true);
      }
      
      private function createCountrySelectorMenuItem(param1:String, param2:String) : IWindowModel
      {
         var _loc3_:IWindowController_1 = IWindowController_1(UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.windowManager.buildFromXML(XML(UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.assets.getAssetByName("phonenumber_country_menu_item_xml").content)));
         _loc3_.name = param1;
         _loc3_.findChildByName("country_code").caption = param2;
         return _loc3_;
      }
      
      private function get selectedCountryCode() : String
      {
         var _loc2_:IDropBaseController_2 = IDropBaseController_2(_window.findChildByName("country_list"));
         if(_loc2_.selection == -1)
         {
            return "NOT_SELECTED";
         }
         var _loc1_:Object = _locales[_loc2_.selection];
         return _loc1_ != null ? _loc1_.code : "--";
      }
      
      private function onNeverAgainConfirmClose(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK" && UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1)
         {
            UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.setNeverAgain();
         }
         param1.dispose();
      }
      
      private function setInputStates(param1:Boolean) : void
      {
         _window.findChildByName("ok_button").disable();
         if(param1)
         {
            _window.findChildByName("phone_number_input").enable();
            _window.findChildByName("never_link").visible = true;
            _window.findChildByName("skip_link").visible = true;
            _window.findChildByName("header_button_close").enable();
            _window.findChildByName("country_list").enable();
         }
         else
         {
            _window.findChildByName("phone_number_input").disable();
            _window.findChildByName("never_link").visible = false;
            _window.findChildByName("skip_link").visible = false;
            _window.findChildByName("header_button_close").disable();
            _window.findChildByName("country_list").disable();
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "skip_link":
                  UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.setCollectViewMinimized(true);
                  break;
               case "never_link":
                  UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.windowManager.confirm("${phone.number.never.again.confirm.title}","${phone.number.never.again.confirm.text}",0,onNeverAgainConfirmClose);
                  break;
               case "ok_button":
                  UnknownVarFromPhoneNumberCollectView_HabboPhoneNumber_1.sendTryPhoneNumber(selectedCountryCode,_window.findChildByName("phone_number_input").caption);
                  setInputStates(false);
                  break;
               case "phone_number_input":
                  if(_inputTextNeedsClearing)
                  {
                     _window.findChildByName("phone_number_input").caption = "";
                     _inputTextNeedsClearing = false;
                  }
                  ITextFieldWindow(_window.findChildByName("phone_number_input")).textColor = 0;
            }
         }
         if(param1.type == "WKE_KEY_UP" && param1.target.name == "phone_number_input")
         {
            if(_window.findChildByName("phone_number_input").caption != null && _window.findChildByName("phone_number_input").caption.length > 0)
            {
               _window.findChildByName("ok_button").enable();
            }
            else
            {
               _window.findChildByName("ok_button").disable();
            }
         }
      }
   }
}

