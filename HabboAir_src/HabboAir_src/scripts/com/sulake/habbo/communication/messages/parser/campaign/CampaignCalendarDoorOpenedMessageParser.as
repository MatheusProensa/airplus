package com.sulake.habbo.communication.messages.parser.campaign
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDoorOpenedMessageParser implements IMessageParser
   {
      private var _doorOpened:Boolean;
      
      private var _productName:String;
      
      private var _customImage:String;
      
      private var _furnitureClassName:String;
      
      public function CampaignCalendarDoorOpenedMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _doorOpened = param1.readBoolean();
         _productName = param1.readString();
         _customImage = param1.readString();
         _furnitureClassName = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         _doorOpened = false;
         _productName = null;
         _customImage = null;
         _furnitureClassName = null;
         return true;
      }
      
      public function get doorOpened() : Boolean
      {
         return _doorOpened;
      }
      
      public function get productName() : String
      {
         return _productName;
      }
      
      public function get customImage() : String
      {
         return _customImage;
      }
      
      public function get furnitureClassName() : String
      {
         return _furnitureClassName;
      }
   }
}

