package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryMainView;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   
   public class EffectsModel implements IInventoryModel
   {
      public static const FILTER_NONE:int = -1;
      
      public static const FILTER_INCLUDE_INACTIVE:int = 0;
      
      public static const FILTER_INCLUDE_ACTIVE:int = 1;
      
      private var UnknownVarFromEffectsModel_HabboInventory_1:HabboInventory;
      
      private var UnknownVarFromEffectsModel_EffectsView_1:EffectsView;
      
      private var UnknownVarFromEffectsModel_Array_1:Array;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _communication:IHabboCommunicationManager;
      
      private var UnknownVarFromEffectsModel_EffectListProxy_1:EffectListProxy;
      
      private var UnknownVarFromEffectsModel_EffectListProxy_2:EffectListProxy;
      
      private var _disposed:Boolean = false;
      
      private var _lastActivatedEffect:int = -1;
      
      public function EffectsModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IHabboLocalizationManager)
      {
         super();
         UnknownVarFromEffectsModel_HabboInventory_1 = param1;
         UnknownVarFromEffectsModel_Array_1 = [];
         _assets = param4;
         _communication = param3;
         UnknownVarFromEffectsModel_EffectListProxy_1 = new EffectListProxy(this,1);
         UnknownVarFromEffectsModel_EffectListProxy_2 = new EffectListProxy(this,0);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get lastActivatedEffect() : int
      {
         return _lastActivatedEffect;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromEffectsModel_HabboInventory_1 = null;
            if(UnknownVarFromEffectsModel_EffectsView_1 != null)
            {
               UnknownVarFromEffectsModel_EffectsView_1.dispose();
            }
            if(UnknownVarFromEffectsModel_EffectListProxy_1 != null)
            {
               UnknownVarFromEffectsModel_EffectListProxy_1.dispose();
               UnknownVarFromEffectsModel_EffectListProxy_1 = null;
            }
            if(UnknownVarFromEffectsModel_EffectListProxy_2 != null)
            {
               UnknownVarFromEffectsModel_EffectListProxy_2.dispose();
               UnknownVarFromEffectsModel_EffectListProxy_2 = null;
            }
            _disposed = true;
         }
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function addEffect(param1:Effect, param2:Boolean = true) : void
      {
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:Effect = getEffect(param1.type);
         if(_loc3_ != null)
         {
            _loc3_.amountInInventory++;
         }
         else
         {
            _loc4_ = BitmapDataAsset(_assets.getAssetByName("fx_icon_" + param1.type + "_png"));
            if(_loc4_ != null)
            {
               param1.iconImage = BitmapData(_loc4_.content);
            }
            UnknownVarFromEffectsModel_Array_1.push(param1);
         }
         if(param2)
         {
            refreshViews();
         }
      }
      
      private function getEffect(param1:int) : Effect
      {
         var _loc3_:int = 0;
         var _loc2_:Effect = null;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromEffectsModel_Array_1.length)
         {
            _loc2_ = UnknownVarFromEffectsModel_Array_1[_loc3_];
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function removeEffect(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Effect = null;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromEffectsModel_Array_1.length)
         {
            _loc2_ = UnknownVarFromEffectsModel_Array_1[_loc3_];
            if(_loc2_.type == param1)
            {
               UnknownVarFromEffectsModel_Array_1.splice(_loc3_,1);
               refreshViews();
               return;
            }
            _loc3_++;
         }
      }
      
      public function refreshViews() : void
      {
         if(UnknownVarFromEffectsModel_EffectsView_1)
         {
            UnknownVarFromEffectsModel_EffectsView_1.updateListViews();
            UnknownVarFromEffectsModel_EffectsView_1.updateActionView();
         }
      }
      
      public function requestEffectActivated(param1:int) : void
      {
         UnknownVarFromEffectsModel_HabboInventory_1.communication.connection.send(new AvatarEffectActivatedComposer(param1));
      }
      
      public function setEffectActivated(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            stopUsingAllEffects(false,false);
            _loc2_.isActive = true;
            _loc2_.isInUse = true;
            refreshViews();
         }
      }
      
      public function useEffect(param1:int) : void
      {
         stopUsingAllEffects(false,false,true);
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(!_loc2_.isActive)
         {
            requestEffectActivated(_loc2_.type);
         }
         if(_loc2_.isInUse == false)
         {
            _loc2_.isInUse = true;
            UnknownVarFromEffectsModel_HabboInventory_1.communication.connection.send(new AvatarEffectSelectedComposer(param1));
            _lastActivatedEffect = param1;
            refreshViews();
         }
      }
      
      public function stopUsingEffect(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:Effect = getEffect(param1);
         if(_loc3_ != null)
         {
            if(_loc3_.isInUse == true)
            {
               _loc3_.isInUse = false;
               if(param2)
               {
                  UnknownVarFromEffectsModel_HabboInventory_1.communication.connection.send(new AvatarEffectSelectedComposer(-1));
                  _lastActivatedEffect = -1;
               }
               refreshViews();
            }
         }
      }
      
      public function stopUsingAllEffects(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Effect = null;
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromEffectsModel_Array_1.length)
         {
            _loc4_ = UnknownVarFromEffectsModel_Array_1[_loc5_];
            _loc4_.isInUse = false;
            _loc5_++;
         }
         if(param1)
         {
            UnknownVarFromEffectsModel_HabboInventory_1.communication.connection.send(new AvatarEffectSelectedComposer(-1));
         }
         if(param2)
         {
            refreshViews();
         }
         if(param3)
         {
            _lastActivatedEffect = -1;
         }
      }
      
      public function toggleEffectSelected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isSelected)
            {
               setEffectDeselected(param1);
            }
            else
            {
               setEffectSelected(param1);
            }
            refreshViews();
         }
      }
      
      public function getEffectInterface(param1:int) : IInventoryMainView
      {
         return getEffect(param1) as IInventoryMainView;
      }
      
      public function setEffectSelected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            setAllEffectsDeselected(false);
            _loc2_.isSelected = true;
            refreshViews();
         }
      }
      
      public function setEffectDeselected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            _loc2_.isSelected = false;
            refreshViews();
         }
      }
      
      private function setAllEffectsDeselected(param1:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Effect = null;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromEffectsModel_Array_1.length)
         {
            _loc2_ = UnknownVarFromEffectsModel_Array_1[_loc3_];
            _loc2_.isSelected = false;
            _loc3_++;
         }
         if(param1)
         {
            refreshViews();
         }
      }
      
      public function getSelectedEffect(param1:int = -1) : Effect
      {
         var _loc4_:int = 0;
         var _loc3_:Effect = null;
         var _loc2_:Array = getEffects(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.isSelected)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getEffects(param1:int = -1) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Effect = null;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromEffectsModel_Array_1.length)
         {
            _loc3_ = UnknownVarFromEffectsModel_Array_1[_loc4_];
            if(_loc3_.isActive && param1 == 1 || !_loc3_.isActive && param1 == 0 || param1 == -1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function setEffectExpired(param1:int) : void
      {
         _lastActivatedEffect = -1;
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.amountInInventory > 1)
            {
               _loc2_.setOneEffectExpired();
               refreshViews();
            }
            else
            {
               removeEffect(_loc2_.type);
            }
         }
      }
      
      public function getItemInIndex(param1:int, param2:int = -1) : Effect
      {
         var _loc3_:Array = getEffects(param2);
         if(param1 < 0 || param1 >= _loc3_.length)
         {
            return null;
         }
         return _loc3_[param1];
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return !!UnknownVarFromEffectsModel_EffectsView_1 ? UnknownVarFromEffectsModel_EffectsView_1.getWindowContainer() : null;
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function reactivateLastEffect() : void
      {
         if(_lastActivatedEffect != -1)
         {
            useEffect(_lastActivatedEffect);
         }
      }
      
      public function updateView() : void
      {
         if(UnknownVarFromEffectsModel_EffectsView_1 && !UnknownVarFromEffectsModel_EffectsView_1.disposed)
         {
            UnknownVarFromEffectsModel_EffectsView_1.updateListViews();
            UnknownVarFromEffectsModel_EffectsView_1.updateActionView();
         }
      }
      
      public function selectItemById(param1:String) : void
      {
         setEffectSelected(int(param1));
      }
   }
}

