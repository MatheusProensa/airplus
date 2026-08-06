package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerStatusMessageParser implements IMessageParser
   {
      private var _recyclerStatus:int = -1;
      
      private var _recyclerTimeoutSeconds:int = 0;
      
      public function RecyclerStatusMessageParser()
      {
         super();
      }
      
      public function get recyclerStatus() : int
      {
         return _recyclerStatus;
      }
      
      public function get recyclerTimeoutSeconds() : int
      {
         return _recyclerTimeoutSeconds;
      }
      
      public function flush() : Boolean
      {
         _recyclerStatus = -1;
         _recyclerTimeoutSeconds = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _recyclerStatus = param1.readInteger();
         _recyclerTimeoutSeconds = param1.readInteger();
         return true;
      }
   }
}

