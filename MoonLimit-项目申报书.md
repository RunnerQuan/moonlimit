# MoonLimit 项目申报书

**基本信息**

- 项目名称：MoonLimit：MoonBit 可组合限流算法与策略工具库
- 参赛者：RunnerQuan
- 联系方式：待填写
- GitHub 仓库链接：https://github.com/RunnerQuan/moonlimit
- Gitlink 仓库链接：待填写
- 项目方向：MoonBit 工程基础设施 / 系统运行时工具库 / 限流与流量治理基础组件
- 是否为移植项目：否，原创项目；参考成熟工程系统中的限流算法思想进行 MoonBit 原生实现

**项目简介**

MoonLimit 是一个面向 MoonBit 生态的可组合限流算法与策略工具库，目标是为 MoonBit 应用、CLI 工具、任务队列、异步服务、API 网关原型和多租户后台系统提供可复用、可测试、可解释的本地限流能力。项目围绕真实工程中的流量治理需求设计，提供 Token Bucket、Leaky Bucket、Fixed Window、Sliding Window、Sliding Log、GCRA、Warmup Token Bucket、Quota Window、Concurrency Limiter 等多种限流模型，并在此基础上提供 keyed limiter、策略组合引擎、规则配置解析、校验诊断、重试建议、workload 仿真、算法元数据和业务 cookbook 场景。

MoonLimit 的设计边界是“纯 MoonBit 的限流核心库”，不绑定特定 Web 框架、数据库、Redis、网关或分布式存储。调用方通过单调毫秒时间驱动限流器，因此核心行为可以在测试和仿真中完全复现。项目当前包含 4k+ 有效 MoonBit 代码行、200+ 自动化测试、可运行 CLI 示例和 GitHub Actions CI，适合作为 MoonBit 生态中的工程基础设施包继续演进。

**核心功能范围**

- 提供统一的 `Decision` 结果模型，返回 `Allowed` / `Rejected` 以及剩余额度、重试等待时间、重置时间和拒绝原因；
- 实现 Token Bucket、Leaky Bucket、Fixed Window、Sliding Window、Sliding Log、GCRA 等常见限流算法，覆盖突发流量、平滑流量、窗口计数和高精度到达时间控制等场景；
- 实现 Warmup Token Bucket、Quota Window、Concurrency Limiter，支持预热限流、长周期配额和并发资源保护；
- 提供 KeyedTokenBucket、KeyedFixedWindow、KeyedSlidingLog、KeyedGcra、KeyedConcurrencyLimiter 等 keyed wrapper，支持按用户、租户、API key、资源 key 进行独立限流；
- 提供 `Duration`、`Rate`、`LimitSpec`、`RuleSet` 等规则配置模型，支持基础文本规则解析、参数规范化和配置校验；
- 提供 `ValidationReport`、`ValidationIssue` 等诊断能力，帮助用户发现规则名称、限额、周期和 refill 参数中的配置风险；
- 提供 `PolicyEngine`，支持 all-of / any-of 策略组合，使多个限流规则可以组合成真实业务策略；
- 提供 `RetryAdvice` 和 `RetrySchedule`，根据拒绝结果生成可解释的重试建议和指数退避计划；
- 提供 deterministic workload 仿真能力，支持 burst、steady、ramp、alternating keys、repeat、shift、merge 等请求序列生成；
- 提供 `SimulationReport`、CSV 输出、允许率/拒绝率、最大等待时间、摘要行等统计能力，用于调参与展示；
- 提供算法文档元数据和 cookbook recipes，覆盖 API 网关、登录保护、搜索框、爬虫礼貌访问、Webhook 分发、邮件/SMS 发送、图片渲染、多租户公平性等常见场景；
- 提供 CLI demo，可直接运行 `moon run cmd/main` 查看限流轨迹、业务配方仿真摘要、算法数量和 cookbook 场景数量；
- 提供完整测试矩阵，目前包含 237 个 MoonBit 测试，覆盖算法边界、keyed 隔离、策略组合、配置解析、workload 仿真、cookbook 场景和回归矩阵；
- 提供 GitHub Actions CI，覆盖 `moon check`、`moon test` 和 CLI 示例运行，保证项目可复现、可验收。

**实现计划与交付说明**

项目已完成 MoonBit 包初始化、核心算法实现、配置模型、策略引擎、仿真工具、业务 cookbook、README、LICENSE、CI 和测试矩阵。后续计划包括：补充更完整的 Mooncakes 发布说明；增加更多真实业务示例；完善规则 DSL 的错误位置提示；探索与 `moonbitlang/async` 的适配示例；在不引入外部运行时依赖的前提下，提供更清晰的包级 API 文档。

当前主要交付物包括：

- MoonBit 源码：24 个 `.mbt` 文件，约 4k+ 有效 MoonBit 代码行；
- 自动化测试：237 个测试，当前 `moon test` 全部通过；
- 可运行示例：`moon run cmd/main`；
- 项目文档：README、MoonBit package metadata、Apache-2.0 License；
- CI 流程：GitHub Actions 自动运行检查、测试和 demo。

**移植或参考说明**

- 原项目名称：无直接移植来源
- 原项目链接：无
- 原项目许可证：不适用
- 本项目许可证：Apache-2.0

本项目为原创 MoonBit 生态库，没有直接复制或移植某个现有开源项目的代码。项目算法层参考了软件工程中成熟的通用限流思想和公开算法模型，例如 token bucket、leaky bucket、fixed/sliding window、sliding log、GCRA、quota window 和 concurrency limiting。实现采用 MoonBit 原生类型、包结构、测试方式和错误/结果建模，不依赖第三方源代码，不包含私有代码、闭源代码或商业代码。

与常见框架内置限流器相比，MoonLimit 做了以下 MoonBit 化和边界控制：

- 不绑定 HTTP 框架、Redis、数据库或特定异步运行时，优先交付可复用的纯算法核心；
- 使用显式单调毫秒时间输入，确保所有限流行为都可以被 deterministic tests 和 simulation 复现；
- 用结构化 `Decision` 返回限流结果，而不是只返回布尔值，方便日志、诊断、重试和用户提示；
- 提供策略组合、配置校验、仿真和 cookbook 场景，帮助 MoonBit 开发者理解不同限流算法的适用边界；
- 以 MoonBit 测试和 CI 为主要质量保障，保证项目能够被下载、运行、检查和继续维护。
