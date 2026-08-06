package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserHabbiconsMessageParser implements IMessageParser
   {
      private var _habbicons:Array;
      
      private var _recentHabbiconIds:Array;
      
      private var UnknownVarFromUserHabbiconsMessageParser_UnknownHabboCommunicationMessagesParserHabbicons4_1:UnknownHabboCommunicationMessagesParserHabbicons4;
      
      public function UserHabbiconsMessageParser()
      {
         super();
         UnknownVarFromUserHabbiconsMessageParser_UnknownHabboCommunicationMessagesParserHabbicons4_1 = new UnknownHabboCommunicationMessagesParserHabbicons4();
         _habbicons = [];
         _recentHabbiconIds = [];
      }
      
      public function get habbicons() : Array
      {
         return _habbicons;
      }
      
      public function get recentHabbiconIds() : Array
      {
         return _recentHabbiconIds;
      }
      
      public function flush() : Boolean
      {
         _habbicons = [];
         _recentHabbiconIds = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _habbicons = [];
         _recentHabbiconIds = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _habbicons.push(UnknownVarFromUserHabbiconsMessageParser_UnknownHabboCommunicationMessagesParserHabbicons4_1.parse(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _recentHabbiconIds.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
   }
}

