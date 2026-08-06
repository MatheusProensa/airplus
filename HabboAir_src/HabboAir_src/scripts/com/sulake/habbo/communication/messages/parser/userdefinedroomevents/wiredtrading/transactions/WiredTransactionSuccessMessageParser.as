package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionSuccessMessageParser implements IMessageParser
   {
      private static var UnknownVarFromWiredTransactionSuccessMessageParser_Int_1:int = 1;
      
      private var _contents:WiredTransactionSuccessContents;
      
      public function WiredTransactionSuccessMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _contents = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = UnknownVarFromWiredTransactionSuccessMessageParser_Int_1++;
         _contents = new WiredTransactionSuccessContents(_loc2_,param1);
         return true;
      }
      
      public function get contents() : WiredTransactionSuccessContents
      {
         return _contents;
      }
   }
}

