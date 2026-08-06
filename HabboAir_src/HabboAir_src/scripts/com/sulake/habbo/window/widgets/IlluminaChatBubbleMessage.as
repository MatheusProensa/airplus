package com.sulake.habbo.window.widgets
{
   [SecureSWF(rename="true")]
   public class IlluminaChatBubbleMessage
   {
      public static const UnknownConstFromIlluminaChatBubbleMessage_Int_1:int = 0;
      
      public static const UnknownConstFromIlluminaChatBubbleMessage_Int_2:int = 1;
      
      private var _type:int;
      
      private var _text:String;
      
      private var _habbiconId:int;
      
      public function IlluminaChatBubbleMessage(param1:int, param2:String = "", param3:int = 0)
      {
         super();
         _type = param1;
         _text = param2;
         _habbiconId = param3;
      }
      
      public static function text(param1:String) : IlluminaChatBubbleMessage
      {
         return new IlluminaChatBubbleMessage(0,param1);
      }
      
      public static function habbicon(param1:int) : IlluminaChatBubbleMessage
      {
         return new IlluminaChatBubbleMessage(1,"",param1);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get textValue() : String
      {
         return _text;
      }
      
      public function get habbiconId() : int
      {
         return _habbiconId;
      }
   }
}

