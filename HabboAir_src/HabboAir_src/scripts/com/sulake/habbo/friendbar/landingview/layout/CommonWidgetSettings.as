package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.IComponent_1;
   
   public class CommonWidgetSettings
   {
      private static const TEXTCOLOR_DEFAULT:uint = 4278190080;
      
      private static const ETCHINGCOLOR_DEFAULT:uint = 4294967295;
      
      private static const ETCHINGPOSITION_DEFAULT:String = "bottom";
      
      private static const UnknownConstFromCommonWidgetSettings_String_1:String = "landing.view.common.textcolor";
      
      private static const ETCHINGCOLOR_CONFIGURATION_KEY:String = "landing.view.common.etchingcolor";
      
      private static const ETCHINGPOSITION_CONFIGURATION_KEY:String = "landing.view.common.etchingposition";
      
      private var _textColor:uint = 4278190080;
      
      private var _etchingColor:uint = 4294967295;
      
      private var _etchingPosition:String = "bottom";
      
      public function CommonWidgetSettings(param1:IComponent_1)
      {
         super();
         if(param1.getProperty("landing.view.common.textcolor") != "")
         {
            _textColor = parseInt(param1.getProperty("landing.view.common.textcolor"),16);
         }
         if(param1.getProperty("landing.view.common.etchingcolor") != "")
         {
            _etchingColor = parseInt(param1.getProperty("landing.view.common.etchingcolor"),16);
         }
         if(param1.getProperty("landing.view.common.etchingposition") != "")
         {
            _etchingPosition = param1.getProperty("landing.view.common.etchingposition");
         }
      }
      
      public function get isTextColorSet() : Boolean
      {
         return _textColor != 4278190080;
      }
      
      public function get isEtchingColorSet() : Boolean
      {
         return _etchingColor != 4294967295;
      }
      
      public function get isEtchingPositionSet() : Boolean
      {
         return _etchingPosition != "bottom";
      }
      
      public function get textColor() : uint
      {
         return _textColor;
      }
      
      public function get etchingColor() : uint
      {
         return _etchingColor;
      }
      
      public function get etchingPosition() : String
      {
         return _etchingPosition;
      }
   }
}

