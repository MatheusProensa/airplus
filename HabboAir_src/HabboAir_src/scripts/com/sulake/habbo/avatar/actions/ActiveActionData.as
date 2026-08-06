package com.sulake.habbo.avatar.actions
{
   public class ActiveActionData implements IActiveActionData
   {
      private var _actionType:String = "";
      
      private var _actionParameter:String = "";
      
      private var _definition:IActionDefinition;
      
      private var _startFrame:int = 0;
      
      private var _overridingAction:String;
      
      public function ActiveActionData(param1:String, param2:String = "", param3:int = 0)
      {
         super();
         _actionType = param1;
         _actionParameter = param2;
         _startFrame = param3;
      }
      
      public function get actionType() : String
      {
         return _actionType;
      }
      
      public function get actionParameter() : String
      {
         return _actionParameter;
      }
      
      public function get definition() : IActionDefinition
      {
         return _definition;
      }
      
      public function get id() : String
      {
         if(_definition == null)
         {
            return "";
         }
         return _definition.id + "_" + _actionParameter;
      }
      
      public function set actionParameter(param1:String) : void
      {
         _actionParameter = param1;
      }
      
      public function set definition(param1:IActionDefinition) : void
      {
         _definition = param1;
      }
      
      public function dispose() : void
      {
         _actionType = null;
         _actionParameter = null;
         _definition = null;
      }
      
      public function get startFrame() : int
      {
         return _startFrame;
      }
      
      public function get overridingAction() : String
      {
         return _overridingAction;
      }
      
      public function set overridingAction(param1:String) : void
      {
         _overridingAction = param1;
      }
      
      public function toString() : String
      {
         return "Action: " + _actionType + "  param: " + _actionParameter;
      }
   }
}

