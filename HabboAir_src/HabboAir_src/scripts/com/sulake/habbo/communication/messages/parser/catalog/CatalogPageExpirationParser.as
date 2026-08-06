package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageExpirationParser implements IMessageParser
   {
      private var _pageName:String;
      
      private var _pageId:int;
      
      private var _secondsToExpiry:int;
      
      private var _image:String;
      
      public function CatalogPageExpirationParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _pageId = param1.readInteger();
         _pageName = param1.readString();
         _secondsToExpiry = param1.readInteger();
         _image = param1.readString();
         return true;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get pageId() : int
      {
         return _pageId;
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

