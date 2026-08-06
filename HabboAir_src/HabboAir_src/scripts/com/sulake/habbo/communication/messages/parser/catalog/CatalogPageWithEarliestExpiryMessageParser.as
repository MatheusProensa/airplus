package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageWithEarliestExpiryMessageParser implements IMessageParser
   {
      private var _pageName:String;
      
      private var _secondsToExpiry:int;
      
      private var _image:String;
      
      public function CatalogPageWithEarliestExpiryMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _pageName = param1.readString();
         _secondsToExpiry = param1.readInteger();
         _image = param1.readString();
         return true;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get secondsToExpiry() : int
      {
         return _secondsToExpiry;
      }
      
      public function get image() : String
      {
         return _image;
      }
   }
}

