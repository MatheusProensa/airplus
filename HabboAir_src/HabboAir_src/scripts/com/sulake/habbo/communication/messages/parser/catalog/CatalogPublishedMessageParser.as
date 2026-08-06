package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPublishedMessageParser implements IMessageParser
   {
      private var _instantlyRefreshCatalogue:Boolean;
      
      private var _newFurniDataHash:String;
      
      public function CatalogPublishedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _instantlyRefreshCatalogue = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _newFurniDataHash = param1.readString();
         }
         return true;
      }
      
      public function get instantlyRefreshCatalogue() : Boolean
      {
         return _instantlyRefreshCatalogue;
      }
      
      public function get newFurniDataHash() : String
      {
         return _newFurniDataHash;
      }
   }
}

