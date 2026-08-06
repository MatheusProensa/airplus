package com.sulake.core.assets
{
   import com.sulake.core.Core;
   import com.sulake.core.runtime.IProfiler_1;
   
   public class LazyAssetProcessor implements IProfiler_1
   {
      private var UnknownVarFromLazyAssetProcessor_Vector_1:Vector.<ILazyAsset> = new Vector.<ILazyAsset>();
      
      private var UnknownVarFromLazyAssetProcessor_Boolean_1:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function LazyAssetProcessor()
      {
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
            Core.instance.removeUpdateReceiver(this);
            UnknownVarFromLazyAssetProcessor_Vector_1 = null;
            UnknownVarFromLazyAssetProcessor_Boolean_1 = false;
            _disposed = true;
         }
      }
      
      public function push(param1:ILazyAsset) : void
      {
         if(param1)
         {
            UnknownVarFromLazyAssetProcessor_Vector_1.push(param1);
            if(!UnknownVarFromLazyAssetProcessor_Boolean_1)
            {
               Core.instance.registerUpdateReceiver(this,2);
               UnknownVarFromLazyAssetProcessor_Boolean_1 = true;
            }
         }
      }
      
      public function flush() : void
      {
         for each(var _loc1_ in UnknownVarFromLazyAssetProcessor_Vector_1)
         {
            if(!_loc1_.disposed)
            {
               _loc1_.prepareLazyContent();
            }
         }
         UnknownVarFromLazyAssetProcessor_Vector_1 = new Vector.<ILazyAsset>();
         if(UnknownVarFromLazyAssetProcessor_Boolean_1)
         {
            Core.instance.removeUpdateReceiver(this);
            UnknownVarFromLazyAssetProcessor_Boolean_1 = false;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:ILazyAsset = UnknownVarFromLazyAssetProcessor_Vector_1.shift();
         if(!_loc2_)
         {
            if(UnknownVarFromLazyAssetProcessor_Boolean_1)
            {
               Core.instance.removeUpdateReceiver(this);
               UnknownVarFromLazyAssetProcessor_Boolean_1 = false;
            }
         }
         else if(!_loc2_.disposed)
         {
            _loc2_.prepareLazyContent();
         }
      }
   }
}

