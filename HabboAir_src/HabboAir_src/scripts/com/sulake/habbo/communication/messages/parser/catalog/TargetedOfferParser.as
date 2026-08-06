package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferData;
   
   [SecureSWF(rename="true")]
   public class TargetedOfferParser implements IMessageParser
   {
      private var _data:TargetedOfferData;
      
      public function TargetedOfferParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new TargetedOfferData().parse(param1);
         return true;
      }
      
      public function get data() : TargetedOfferData
      {
         return _data;
      }
   }
}

