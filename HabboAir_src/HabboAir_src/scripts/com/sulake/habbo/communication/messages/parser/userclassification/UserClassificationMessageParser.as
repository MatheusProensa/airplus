package com.sulake.habbo.communication.messages.parser.userclassification
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class UserClassificationMessageParser implements IMessageParser
   {
      private var _classifiedUsernameMap:Map;
      
      private var _classifiedUserTypeMap:Map;
      
      public function UserClassificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_classifiedUsernameMap)
         {
            _classifiedUsernameMap.dispose();
            _classifiedUsernameMap = null;
         }
         if(_classifiedUserTypeMap)
         {
            _classifiedUserTypeMap.dispose();
            _classifiedUserTypeMap = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _classifiedUsernameMap = new Map();
         _classifiedUserTypeMap = new Map();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc5_ = param1.readString();
            _classifiedUsernameMap.add(_loc4_,_loc6_);
            _classifiedUserTypeMap.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
      
      public function get classifiedUsernameMap() : Map
      {
         return _classifiedUsernameMap;
      }
      
      public function get classifiedUserTypeMap() : Map
      {
         return _classifiedUserTypeMap;
      }
   }
}

