//! Kernel-specific error types.

use lumys_types::error::LumysError;
use thiserror::Error;

/// Kernel error type wrapping LumysError with kernel-specific context.
#[derive(Error, Debug)]
pub enum KernelError {
    /// A wrapped LumysError.
    #[error(transparent)]
    Lumys OS(#[from] LumysError),

    /// The kernel failed to boot.
    #[error("Boot failed: {0}")]
    BootFailed(String),
}

/// Alias for kernel results.
pub type KernelResult<T> = Result<T, KernelError>;
