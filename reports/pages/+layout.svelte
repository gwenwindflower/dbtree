<script>
  import "@evidence-dev/tailwind/fonts.css";
  import "../app.css";
  import { EvidenceDefaultLayout } from "@evidence-dev/core-components";
  export let data;
</script>

<EvidenceDefaultLayout
  {data}
  title="🌲 dbtree 🌳"
  githubRepo="https://github.com/gwenwindflower/dbtree"
  builtWithEvidence={true}
  logo="/logo.png"
>
  <slot slot="content" />
</EvidenceDefaultLayout>
