package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ExpressionMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _expressionType:int = -1;
      
      public function ExpressionMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get expressionType() : int
      {
         return _expressionType;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         _expressionType = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _expressionType = param1.readInteger();
         return true;
      }
   }
}

