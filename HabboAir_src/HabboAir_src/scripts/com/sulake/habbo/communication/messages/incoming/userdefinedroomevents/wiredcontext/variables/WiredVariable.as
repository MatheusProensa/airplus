package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.Map;
   
   public class WiredVariable
   {
      public static var UnknownVarFromWiredVariable_String_1:String = "n";
      
      private var _variableId:String;
      
      private var _variableType:int;
      
      private var _variableName:String;
      
      private var _availabilityType:int;
      
      private var _variableTarget:int;
      
      private var _alwaysAvailable:Boolean;
      
      private var _canCreateAndDelete:Boolean;
      
      private var _hasValue:Boolean;
      
      private var _canWriteValue:Boolean;
      
      private var _canInterceptChanges:Boolean;
      
      private var _isInvisible:Boolean;
      
      private var _canReadCreationTime:Boolean;
      
      private var _canReadLastUpdateTime:Boolean;
      
      private var _textConnector:Map;
      
      public function WiredVariable(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         super();
         _variableId = param1.readString();
         _variableType = param1.readInteger();
         _variableName = param1.readString();
         _availabilityType = param1.readInteger();
         _variableTarget = param1.readInteger();
         _alwaysAvailable = param1.readBoolean();
         _canCreateAndDelete = param1.readBoolean();
         _hasValue = param1.readBoolean();
         _canWriteValue = param1.readBoolean();
         _canInterceptChanges = param1.readBoolean();
         _isInvisible = param1.readBoolean();
         _canReadCreationTime = param1.readBoolean();
         _canReadLastUpdateTime = param1.readBoolean();
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            _textConnector = new Map();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc6_ = param1.readInteger();
               _loc5_ = param1.readString();
               _textConnector.add(_loc6_,_loc5_);
               _loc4_++;
            }
         }
      }
      
      public function get variableId() : String
      {
         return _variableId;
      }
      
      public function get variableType() : int
      {
         return _variableType;
      }
      
      public function get variableName() : String
      {
         return _variableName;
      }
      
      public function get availabilityType() : int
      {
         return _availabilityType;
      }
      
      public function get variableTarget() : int
      {
         return _variableTarget;
      }
      
      public function get alwaysAvailable() : Boolean
      {
         return _alwaysAvailable;
      }
      
      public function get canCreateAndDelete() : Boolean
      {
         return _canCreateAndDelete;
      }
      
      public function get hasValue() : Boolean
      {
         return _hasValue;
      }
      
      public function get canWriteValue() : Boolean
      {
         return _canWriteValue;
      }
      
      public function get canInterceptChanges() : Boolean
      {
         return _canInterceptChanges;
      }
      
      public function get isInvisible() : Boolean
      {
         return _isInvisible;
      }
      
      public function get canReadCreationTime() : Boolean
      {
         return _canReadCreationTime;
      }
      
      public function get canReadLastUpdateTime() : Boolean
      {
         return _canReadLastUpdateTime;
      }
      
      public function get hasTextConnector() : Boolean
      {
         return _textConnector != null;
      }
      
      public function get textConnector() : Map
      {
         return _textConnector;
      }
      
      public function get isStored() : Boolean
      {
         return _availabilityType < 100;
      }
      
      public function get isPersisted() : Boolean
      {
         return _availabilityType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2_Int_3 || _availabilityType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2_Int_4 || _availabilityType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2_Int_5;
      }
   }
}

