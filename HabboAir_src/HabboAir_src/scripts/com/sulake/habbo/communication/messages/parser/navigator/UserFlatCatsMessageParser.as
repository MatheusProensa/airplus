package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   
   [SecureSWF(rename="true")]
   public class UserFlatCatsMessageParser implements IMessageParser
   {
      private var _nodes:Array;
      
      public function UserFlatCatsMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _nodes = [];
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _nodes.push(new FlatCategory(param1));
            _loc2_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _nodes = null;
         return true;
      }
      
      public function get nodes() : Array
      {
         return _nodes;
      }
   }
}

