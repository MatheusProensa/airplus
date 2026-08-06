package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IssuePickFailedMessageParser implements IMessageParser
   {
      private var _issues:Array;
      
      private var _retryEnabled:Boolean;
      
      private var _retryCount:int;
      
      public function IssuePickFailedMessageParser()
      {
         super();
      }
      
      public function get issues() : Array
      {
         return _issues;
      }
      
      public function get retryEnabled() : Boolean
      {
         return _retryEnabled;
      }
      
      public function get retryCount() : int
      {
         return _retryCount;
      }
      
      public function flush() : Boolean
      {
         _issues = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:IssueMessageData = null;
         _issues = [];
         var _loc6_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_ = param1.readInteger();
            _loc2_ = param1.readInteger();
            _loc5_ = param1.readString();
            _loc4_ = new IssueMessageData(_loc3_,0,0,0,0,0,0,0,null,0,null,_loc2_,_loc5_,null,0,[]);
            _issues.push(_loc4_);
            _loc7_++;
         }
         _retryEnabled = param1.readBoolean();
         _retryCount = param1.readInteger();
         return true;
      }
   }
}

