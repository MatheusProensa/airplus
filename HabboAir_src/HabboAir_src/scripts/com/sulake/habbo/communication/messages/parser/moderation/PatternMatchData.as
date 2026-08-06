package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class PatternMatchData implements IComponentInterfaceQueue
   {
      private var _pattern:String;
      
      private var _startIndex:int;
      
      private var _endIndex:int;
      
      private var _disposed:Boolean = false;
      
      public function PatternMatchData(param1:IMessageDataWrapper)
      {
         super();
         _pattern = param1.readString();
         _startIndex = param1.readInteger();
         _endIndex = param1.readInteger();
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _pattern = "";
         _startIndex = -1;
         _endIndex = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get pattern() : String
      {
         return _pattern;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function get endIndex() : int
      {
         return _endIndex;
      }
   }
}

