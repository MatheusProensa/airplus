package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
   
   [SecureSWF(rename="true")]
   public class HabboSearchResultMessageParser implements IMessageParser
   {
      private var UnknownVarFromHabboSearchResultMessageParser_Array_1:Array;
      
      private var _others:Array;
      
      public function HabboSearchResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.UnknownVarFromHabboSearchResultMessageParser_Array_1 = [];
         this._others = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.UnknownVarFromHabboSearchResultMessageParser_Array_1.push(new HabboSearchResultData(param1));
            _loc3_++;
         }
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this._others.push(new HabboSearchResultData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get friends() : Array
      {
         return this.UnknownVarFromHabboSearchResultMessageParser_Array_1;
      }
      
      public function get others() : Array
      {
         return this._others;
      }
   }
}

