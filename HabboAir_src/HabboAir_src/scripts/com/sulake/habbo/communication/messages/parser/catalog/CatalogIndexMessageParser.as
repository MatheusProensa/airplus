package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   
   [SecureSWF(rename="true")]
   public class CatalogIndexMessageParser implements IMessageParser
   {
      private var _root:NodeData;
      
      private var _newAdditionsAvailable:Boolean;
      
      private var _catalogType:String;
      
      public function CatalogIndexMessageParser()
      {
         super();
      }
      
      public function get root() : NodeData
      {
         return _root;
      }
      
      public function get newAdditionsAvailable() : Boolean
      {
         return _newAdditionsAvailable;
      }
      
      public function get catalogType() : String
      {
         return _catalogType;
      }
      
      public function flush() : Boolean
      {
         _root = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _root = new NodeData(param1);
         _newAdditionsAvailable = param1.readBoolean();
         _catalogType = param1.readString();
         return true;
      }
   }
}

