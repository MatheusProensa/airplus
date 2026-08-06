package com.sulake.habbo.communication.messages.parser.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.TopLevelContext;
   
   [SecureSWF(rename="true")]
   public class NavigatorMetaDataParser implements IMessageParser
   {
      private var _topLevelContexts:Vector.<TopLevelContext>;
      
      public function NavigatorMetaDataParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _topLevelContexts = new Vector.<TopLevelContext>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _topLevelContexts.push(new TopLevelContext(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get topLevelContexts() : Vector.<TopLevelContext>
      {
         return _topLevelContexts;
      }
   }
}

