package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class InstantMessageContentData
   {
      public static const UnknownConstFromIlluminaChatBubbleMessage_Int_1:int = 0;
      
      public static const UnknownConstFromIlluminaChatBubbleMessage_Int_2:int = 1;
      
      private var _messageType:int;
      
      private var _messageText:String;
      
      private var _habbiconId:int;
      
      public function InstantMessageContentData(param1:int, param2:String = "", param3:int = 0)
      {
         super();
         _messageType = param1;
         _messageText = param2;
         _habbiconId = param3;
      }
      
      public static function parse(param1:IMessageDataWrapper) : InstantMessageContentData
      {
         var _loc2_:int = param1.readInteger();
         switch(_loc2_)
         {
            case 0:
               return new InstantMessageContentData(0,param1.readString(),0);
            case 1:
               return new InstantMessageContentData(1,"",param1.readInteger());
            default:
               return new InstantMessageContentData(0,"",0);
         }
      }
      
      public function get messageType() : int
      {
         return _messageType;
      }
      
      public function get messageText() : String
      {
         return _messageText;
      }
      
      public function get habbiconId() : int
      {
         return _habbiconId;
      }
   }
}

