package com.sulake.core.window.services
{
   import com.sulake.core.window.components.ITextFieldController;
   import com.sulake.core.window.utils.*;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   
   public class FocusManager implements IFocusManager
   {
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromFocusManager_Stage_1:Stage;
      
      private var UnknownVarFromFocusManager_Vector_1:Vector.<ITextFieldController> = new Vector.<ITextFieldController>();
      
      public function FocusManager(param1:DisplayObject)
      {
         UnknownVarFromFocusManager_Stage_1 = param1.stage;
         UnknownVarFromFocusManager_Stage_1.addEventListener("activate",onActivateEvent);
         UnknownVarFromFocusManager_Stage_1.addEventListener("focusOut",onFocusEvent);
         UnknownVarFromFocusManager_Stage_1.addEventListener("keyFocusChange",onFocusEvent);
         UnknownVarFromFocusManager_Stage_1.addEventListener("mouseFocusChange",onFocusEvent);
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromFocusManager_Stage_1.removeEventListener("activate",onActivateEvent);
            UnknownVarFromFocusManager_Stage_1.removeEventListener("focusOut",onFocusEvent);
            UnknownVarFromFocusManager_Stage_1.removeEventListener("keyFocusChange",onFocusEvent);
            UnknownVarFromFocusManager_Stage_1.removeEventListener("mouseFocusChange",onFocusEvent);
            UnknownVarFromFocusManager_Stage_1 = null;
            _disposed = true;
            UnknownVarFromFocusManager_Vector_1 = null;
         }
      }
      
      public function registerFocusWindow(param1:ITextFieldController) : void
      {
         if(param1 != null)
         {
            if(UnknownVarFromFocusManager_Vector_1.indexOf(param1) == -1)
            {
               UnknownVarFromFocusManager_Vector_1.push(param1);
               if(UnknownVarFromFocusManager_Stage_1.focus == null)
               {
                  param1.focus();
               }
            }
         }
      }
      
      public function removeFocusWindow(param1:ITextFieldController) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = int(UnknownVarFromFocusManager_Vector_1.indexOf(param1));
            if(_loc2_ > -1)
            {
               UnknownVarFromFocusManager_Vector_1.splice(_loc2_,1);
            }
         }
         if(UnknownVarFromFocusManager_Stage_1.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function resolveNextFocusTarget() : ITextFieldController
      {
         var _loc1_:ITextFieldController = null;
         var _loc2_:uint = UnknownVarFromFocusManager_Vector_1.length;
         while(_loc2_-- != 0)
         {
            _loc1_ = UnknownVarFromFocusManager_Vector_1[_loc2_] as ITextFieldController;
            if(!_loc1_.disposed)
            {
               _loc1_.focus();
               break;
            }
            UnknownVarFromFocusManager_Vector_1.splice(_loc2_,1);
         }
         return _loc1_;
      }
      
      private function onActivateEvent(param1:Event) : void
      {
         if(UnknownVarFromFocusManager_Stage_1.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function onFocusEvent(param1:FocusEvent) : void
      {
         if(UnknownVarFromFocusManager_Stage_1.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
   }
}

