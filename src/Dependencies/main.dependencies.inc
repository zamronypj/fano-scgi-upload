(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

container.add(
    'upload-validator',
    TUploadValidatorFactory.create()
);


container.add(
    'upload-validation-middleware',
    TUploadValidationMiddlewareFactory.create()
);
