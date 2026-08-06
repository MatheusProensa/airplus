package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ClaimItem extends CollectibleBaseItem
   {
      private var _setId:String;
      
      private var _defaultCollectionName:String;
      
      public function ClaimItem(param1:IMessageDataWrapper)
      {
         super(param1);
         _setId = param1.readString();
         _defaultCollectionName = param1.readString();
      }
      
      public function get setId() : String
      {
         return _setId;
      }
      
      public function get defaultCollectionName() : String
      {
         return _defaultCollectionName;
      }
   }
}

