package com.sulake.habbo.notifications.feed
{
   public class StateController
   {
      private var UnknownVarFromStateController_Boolean_1:Boolean;
      
      private var _isGameMode:Boolean;
      
      private var _currentState:int = 0;
      
      private var UnknownVarFromStateController_Int_1:int = 1;
      
      public function StateController()
      {
         super();
      }
      
      private function isActive() : Boolean
      {
         return UnknownVarFromStateController_Boolean_1 && !_isGameMode;
      }
      
      public function setEnabled(param1:Boolean) : int
      {
         UnknownVarFromStateController_Boolean_1 = param1;
         if(!isActive())
         {
            return requestState(0);
         }
         return setVisible();
      }
      
      public function setGameMode(param1:Boolean) : int
      {
         _isGameMode = param1;
         if(!isActive())
         {
            return requestState(0);
         }
         return setVisible();
      }
      
      public function currentState() : int
      {
         return _currentState;
      }
      
      public function requestState(param1:int) : int
      {
         if(!isActive())
         {
            UnknownVarFromStateController_Int_1 = param1;
            return _currentState;
         }
         _currentState = param1;
         UnknownVarFromStateController_Int_1 = param1;
         return _currentState;
      }
      
      private function setVisible() : int
      {
         var _loc1_:int = UnknownVarFromStateController_Int_1;
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         _currentState = _loc1_;
         UnknownVarFromStateController_Int_1 = _loc1_;
         return _loc1_;
      }
   }
}

