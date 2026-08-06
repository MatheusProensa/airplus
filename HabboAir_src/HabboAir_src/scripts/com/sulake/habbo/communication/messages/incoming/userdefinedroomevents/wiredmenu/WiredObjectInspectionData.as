package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.Map;
   
   public class WiredObjectInspectionData
   {
      private static var UnknownVarFromWiredObjectInspectionData_Int_1:int = 0;
      
      private static var UnknownVarFromWiredObjectInspectionData_Int_2:int = 1;
      
      private static var UnknownVarFromWiredObjectInspectionData_Int_3:int = -10;
      
      private var _type:int;
      
      private var _userIndex:int;
      
      private var _objectId:int;
      
      private var _variableValues:Map;
      
      private var _configuredInWireds:Vector.<int> = null;
      
      public function WiredObjectInspectionData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         super();
         _type = param1.readInteger();
         if(_type == UnknownVarFromWiredObjectInspectionData_Int_1)
         {
            _objectId = param1.readInteger();
         }
         else if(_type == UnknownVarFromWiredObjectInspectionData_Int_2)
         {
            _userIndex = param1.readInteger();
         }
         _variableValues = new Map();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readString();
            _loc6_ = param1.readInteger();
            _variableValues.add(_loc5_,_loc6_);
            _loc4_ += 1;
         }
         if(_type == UnknownVarFromWiredObjectInspectionData_Int_1)
         {
            _loc3_ = param1.readInteger();
            _configuredInWireds = new Vector.<int>();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = param1.readInteger();
               _configuredInWireds.push(_loc2_);
               _loc4_ += 1;
            }
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get userIndex() : int
      {
         return _userIndex;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get variableValues() : Map
      {
         return _variableValues;
      }
      
      public function get configuredInWireds() : Vector.<int>
      {
         return _configuredInWireds;
      }
   }
}

