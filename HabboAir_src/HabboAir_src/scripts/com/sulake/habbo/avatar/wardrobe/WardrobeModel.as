package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
   
   public class WardrobeModel implements ISideContentModel
   {
      private var _controller:HabboAvatarEditor;
      
      private var UnknownVarFromWardrobeModel_WardrobeView_1:WardrobeView;
      
      private var UnknownVarFromWardrobeModel_Map_1:Map;
      
      private var UnknownVarFromWardrobeModel_Boolean_1:Boolean = false;
      
      public function WardrobeModel(param1:HabboAvatarEditor)
      {
         super();
         _controller = param1;
      }
      
      public function get availableSlots() : int
      {
         return _controller.manager.getInteger("avatareditor.wardrobe.slots",10);
      }
      
      public function dispose() : void
      {
         _controller = null;
         for each(var _loc1_ in UnknownVarFromWardrobeModel_Map_1)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         UnknownVarFromWardrobeModel_Map_1 = null;
         if(UnknownVarFromWardrobeModel_WardrobeView_1)
         {
            UnknownVarFromWardrobeModel_WardrobeView_1.dispose();
            UnknownVarFromWardrobeModel_WardrobeView_1 = null;
         }
         UnknownVarFromWardrobeModel_Boolean_1 = false;
      }
      
      public function reset() : void
      {
         UnknownVarFromWardrobeModel_Boolean_1 = false;
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         if(UnknownVarFromWardrobeModel_WardrobeView_1)
         {
            UnknownVarFromWardrobeModel_WardrobeView_1.dispose();
         }
         UnknownVarFromWardrobeModel_WardrobeView_1 = new WardrobeView(this);
         if(_controller.handler != null)
         {
            _controller.handler.getWardrobe();
         }
         if(UnknownVarFromWardrobeModel_Map_1)
         {
            for each(var _loc2_ in UnknownVarFromWardrobeModel_Map_1)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         UnknownVarFromWardrobeModel_Map_1 = new Map();
         _loc1_ = 1;
         while(_loc1_ <= availableSlots)
         {
            UnknownVarFromWardrobeModel_Map_1.add(_loc1_,new WardrobeSlot(UnknownVarFromWardrobeModel_WardrobeView_1.slotTemplate,_controller,_loc1_,isSlotEnabled(_loc1_)));
            _loc1_++;
         }
         UnknownVarFromWardrobeModel_Boolean_1 = true;
         updateView();
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return _controller;
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromWardrobeModel_Boolean_1)
         {
            init();
         }
         return UnknownVarFromWardrobeModel_WardrobeView_1.getWindowContainer();
      }
      
      private function updateView() : void
      {
         UnknownVarFromWardrobeModel_WardrobeView_1.update();
      }
      
      public function updateSlots(param1:int, param2:Array) : void
      {
         var _loc3_:WardrobeSlot = null;
         if(!UnknownVarFromWardrobeModel_Boolean_1)
         {
            return;
         }
         if(!param2)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: outfits is null!");
         }
         if(!UnknownVarFromWardrobeModel_Map_1)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: _slots is null!");
         }
         for each(var _loc4_ in param2)
         {
            _loc3_ = UnknownVarFromWardrobeModel_Map_1.getValue(_loc4_.slotId) as WardrobeSlot;
            if(_loc3_)
            {
               _loc3_.update(_loc4_.figureString,_loc4_.gender,isSlotEnabled(_loc3_.id));
            }
         }
      }
      
      private function isSlotEnabled(param1:int) : Boolean
      {
         return true;
      }
      
      public function get slots() : Array
      {
         return UnknownVarFromWardrobeModel_Map_1.getValues();
      }
   }
}

