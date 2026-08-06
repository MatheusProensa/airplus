package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GetForumsListMessageParser implements IMessageParser
   {
      private var _listCode:int;
      
      private var _totalAmount:int;
      
      private var _startIndex:int;
      
      private var _amount:int;
      
      private var _forums:Array;
      
      public function GetForumsListMessageParser()
      {
         super();
      }
      
      public function get listCode() : int
      {
         return _listCode;
      }
      
      public function get totalAmount() : int
      {
         return _totalAmount;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get forums() : Array
      {
         return _forums;
      }
      
      public function flush() : Boolean
      {
         _forums = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _listCode = param1.readInteger();
         _totalAmount = param1.readInteger();
         _startIndex = param1.readInteger();
         _amount = param1.readInteger();
         _forums = [];
         _loc2_ = 0;
         while(_loc2_ < amount)
         {
            _forums.push(ForumData.readFromMessage(param1));
            _loc2_++;
         }
         return true;
      }
   }
}

