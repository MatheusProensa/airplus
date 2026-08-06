package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredVariableStorageParameter
   {
      private var _variableId:String;
      
      private var _value:int;
      
      private var _creationTime:Number;
      
      private var _creationTimeStr:String;
      
      private var _lastUpdateTime:Number;
      
      private var _lastUpdateTimeStr:String;
      
      public function WiredVariableStorageParameter(param1:IMessageDataWrapper, param2:Boolean = false)
      {
         super();
         if(param2)
         {
            _variableId = param1.readString();
         }
         _value = param1.readInteger();
         _creationTime = param1.readLong();
         _creationTimeStr = param1.readString();
         _lastUpdateTime = param1.readLong();
         _lastUpdateTimeStr = param1.readString();
      }
      
      public function get variableId() : String
      {
         return _variableId;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get creationTime() : Number
      {
         return _creationTime;
      }
      
      public function get creationTimeStr() : String
      {
         return _creationTimeStr;
      }
      
      public function get lastUpdateTime() : Number
      {
         return _lastUpdateTime;
      }
      
      public function get lastUpdateTimeStr() : String
      {
         return _lastUpdateTimeStr;
      }
   }
}

