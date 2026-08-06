package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfo;
   
   [SecureSWF(rename="true")]
   public class RelationshipStatusInfoMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _relationshipStatusMap:Map;
      
      public function RelationshipStatusInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_relationshipStatusMap)
         {
            _relationshipStatusMap.dispose();
            _relationshipStatusMap = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:RelationshipStatusInfo = null;
         _userId = param1.readInteger();
         _relationshipStatusMap = new Map();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new RelationshipStatusInfo(param1);
            _relationshipStatusMap.add(_loc4_.relationshipStatusType,_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get relationshipStatusMap() : Map
      {
         return _relationshipStatusMap;
      }
   }
}

